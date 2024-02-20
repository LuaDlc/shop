import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  // Future<void> _refreshOrders(BuildContext context) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //verifica se o estado esta esperando ou nao
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('Ocorreu um erro'),
            );
          } else {
            return Consumer<OrderList>(
              builder: (context, orders, child) => ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
              ),
            );
          }
        },
      ),
    );
  }
}

/*usando o future builder, ajuda a trabalhar com codigo assincrono
e ter acesso ao estado da conexao e saber entao se esta no modo waiting
saber se gerou algum errro e tratar diferentes cenarios
trabalha com requisicoes assincronas usando future

obs: podemos trabalhar com um widget do tipo statelesss e ter o estado
*/
