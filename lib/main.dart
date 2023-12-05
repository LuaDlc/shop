import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_overview_page.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
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
            AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
          }),
    );
  }
}
