// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badgee.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';
import '../components/product_grid.dart';
import '../models/cart.dart';

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: const Text(
          'Minha loja',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert_sharp,
              color: Colors.white,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favoritos,
                child: Text('Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all, //apenas o enum do popup
                child: Text('Todos'),
              ),
            ],
            onSelected: (FilterOptions selectedvalue) {
              setState(() {
                if (selectedvalue == FilterOptions.favoritos) {
                  _showFavoriteOnly = true;
                  //funcao do product_list q retorna favorite caso true
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.cart);
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
              builder: (ctx, cart, child) => Badgee(
                    value: cart.itemsCount.toString(),
                    child: child!,
                  ))
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductGrid(
              _showFavoriteOnly,
            ),
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          backgroundColor: Colors.deepPurple[300],
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.stars_rounded), label: 'Destaques'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_outlined), label: 'Categorias'),
          ]),
    );
  }
}

enum FilterOptions { favoritos, all }

//product list