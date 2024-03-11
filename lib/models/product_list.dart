import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/constants.dart';

class ProductList with ChangeNotifier {
  //final _baseUrl = Constants.productBaseUrl;
  final String _token;
  final String _userId;
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  ProductList(
      [this._token = '',
      this._userId = '',
      this._items = const []]); //inicializados como parametros opcionais

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'),
    );

    if (response.body == 'null') return;
    final favResponse = await http.put(
      Uri.parse(
          '${Constants.userFavoritesUrl}/$_userId.json?auth=$_token'), //requisicao para obter os favoritos
    );

    Map<String, dynamic> favData = favResponse.body == 'null'
        ? {}
        : jsonDecode(favResponse.body); //pegando os dados de favoritos

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      //saber se o prod esta favorito ou nao
      final isFavorite = favData[productId] ?? false;
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
        ),
      );
    });

    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse(
            '${Constants.productBaseUrl}/${product.id}.json?auth=$_token'),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product =
          _items[index]; //pega o item a partir do index e armazena no product
      _items.remove(product); //remove diretamente o product/index
      //exclusao otimista, exclui localmente primeiro para o usuario
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
            '${Constants.productBaseUrl}/${product.id}.json?auth=$_token'),
      ); //depois no banco, caso de problema, traz feedback
      if (response.statusCode >= 400) {
        //erros da fmailia dos 400 é um erro do cliente e 500 lado do servidor, nesses casos
        //ha um problema de requisição
        _items.insert(
            index, product); //reinsere o item pelo index e passando o produto
        notifyListeners();
        throw HttpException(
            msg: 'Não foi possível excluir o produto.',
            statusCode: response
                .statusCode); //tratar essa exceçao dentro do product item
      }
    }
  }
}
