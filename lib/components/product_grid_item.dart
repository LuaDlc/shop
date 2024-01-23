// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/utils/app_routes.dart';

import '../models/cart.dart';
import '../models/product.model.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: true);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
            backgroundColor: Colors.black38,
            leading: IconButton(
                onPressed: () {
                  product.toggleFavorite();
                },
                icon: Icon(
                  product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: Theme.of(context).hintColor,
                )),
            title: Text(
              product.name!,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Produdo adicionado com sucesso!'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'DESFAZER',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  ));
                  cart.addItem(product);
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).hintColor,
                ))),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.productDetail, arguments: product);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}