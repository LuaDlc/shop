// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.name),
              background: Stack(
                  fit: StackFit.expand, //serve para expandir a imagem
                  children: [
                    Hero(
                      tag: product.id,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const DecoratedBox(
                        //decorationbox para colocar um gradiente e melhorar a vizualizacao do texto
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment(0, 0.8),
                                end: Alignment(0, 0),
                                colors: [
                          Color.fromRGBO(
                            0,
                            0,
                            0,
                            0.6,
                          ),
                          Color.fromRGBO(0, 0, 0, 0)
                        ])))
                  ]),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
              ),
              Text(
                'R\$ ${product.price}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),
        ],
        // child: Column(
        //   children: [
        //     SizedBox(
        //       height: 300,
        //       width: double.infinity,
        //       child: Hero(
        //         //hero animation faz a imagem crescer na transicao de tela
        //         tag: product.id,
        //         child: Image.network(
        //           product.imageUrl,
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 10,
        //     ),
        //     Text('R\$ ${product.price}'),
        //     const SizedBox(
        //       height: 10,
        //     ),
        //     Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 10),
        //       child: Text(
        //         product.description,
        //         textAlign: TextAlign.center,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
