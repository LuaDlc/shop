// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../components/product_grid.dart';

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
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
              setState(() {
                if (selectedvalue == FilterOptions.favoritos) {
                  _showFavoriteOnly = true;
                  //funcao do product_list q retorna favorite caso true
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          )
        ],
      ),
      body: ProductGrid(
        _showFavoriteOnly,
      ),
    );
  }
}

enum FilterOptions { favoritos, all }
