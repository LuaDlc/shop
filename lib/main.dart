import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/product_overview_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/utils/app_routes.dart';

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
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
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
          home: const ProductOverviewPage(),
          routes: {
            AppRoutes.home: (ctx) => const ProductOverviewPage(),
            AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
            AppRoutes.cartPage: (ctx) => const CartPage(),
            AppRoutes.orders: (ctx) => const OrdersPage(),
            AppRoutes.products: (ctx) => const ProductPage(),
            AppRoutes.productForm: (ctx) => const ProductFormPage(),
          }),
    );
  }
}
/*



compoment order
cartpage
*/