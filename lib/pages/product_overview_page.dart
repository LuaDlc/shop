// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import '../components/product_grid.dart';

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ProductList>(context); //instancia do ProductList
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_sharp),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favoritos,
                child: Text('favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all, //apenas o enum do popup
                child: Text('todos'),
              ),
            ],
            onSelected: (FilterOptions selectedvalue) {
              if (selectedvalue == FilterOptions.favoritos) {
                provider
                    .showOnlyFavorite(); //funcao do product_list q retorna favorite caso true
              } else {
                provider.showAll();
              }
            },
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: ProductGrid(),
      ),
    );
  }
}

enum FilterOptions { favoritos, all }
