// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key? key,
    required this.cartItem,
  }) : super(key: key);
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Text(cartItem.name);
  }
}
