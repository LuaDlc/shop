// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../components/product_grid.dart';

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: ProductGrid(),
      ),
    );
  }
}
