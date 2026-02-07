import 'package:flutter/material.dart';
import 'package:tartibat/features/customer/widgets/cart/cart_empty.dart';

import '../widgets/cart/cart_app_bar.dart';
import '../widgets/cart/cart_list.dart';
import '../widgets/cart/cart_total_bottom.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> _cartItems = [];

  int get _totalPrice => _cartItems.fold(
        0,
        (sum, item) =>
            sum + ((item['price'] as int) * (item['quantity'] as int)),
      );

  void _removeItem(int index) {
    setState(() => _cartItems.removeAt(index));
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() => _cartItems[index]['quantity'] = newQuantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CartAppBar(itemCount: _cartItems.length),
      body: _cartItems.isEmpty
          ? const CartEmptyClean()
          : Column(
              children: [
                Expanded(
                  child: CartList(
                    items: _cartItems,
                    onRemove: _removeItem,
                    onQuantityChanged: _updateQuantity,
                  ),
                ),
                CartTotalBottom(totalPrice: _totalPrice, onCheckout: () {}),
              ],
            ),
    );
  }
}
