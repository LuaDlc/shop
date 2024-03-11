import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/utils/app_routes.dart';

import 'pages/auth_or_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          //usando o proxy pq dependo de um unico provider(auth)
          create: (_) => ProductList('', []),
          update: (context, auth, previous) {
            return ProductList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
            update: (ctx, auth, previous) {
              return OrderList(auth.token ?? '', previous?.items ?? []);
            },
            create: (_) => OrderList('', [])),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Colors.purple),
            hintColor: Colors.red,
            primarySwatch: Colors.purple,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'Lato',
          ),
          //home: const AuthPage(),
          routes: {
            AppRoutes.authOrHome: (ctx) => const AuthOrHomePage(),
            AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
            AppRoutes.cart: (ctx) => const CartPage(),
            AppRoutes.orders: (ctx) => const OrdersPage(),
            AppRoutes.products: (ctx) => const ProductPage(),
            AppRoutes.productForm: (ctx) => const ProductFormPage(),
          }),
    );
  }
}
/*

auth.dart -> userId
product -> models //put pra substituir a informacao, mandando apenas o valor true or false
product_grid_items -> componentes
constants
prodcut list -> models

*/