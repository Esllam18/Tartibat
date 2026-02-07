import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/cart/cart_app_bar.dart';
import '../widgets/cart/cart_list.dart';
import '../widgets/cart/cart_checkout.dart';
import '../widgets/cart/cart_empty.dart';

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

  void _clearCart() {
    setState(() => _cartItems.clear());
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() => _cartItems[index]['quantity'] = newQuantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CartAppBar(
        itemCount: _cartItems.length,
        onClearAll: _cartItems.isNotEmpty ? _clearCart : null,
      ),
      body: _cartItems.isEmpty
          ? const CartEmpty()
          : Column(
              children: [
                Expanded(
                  child: CartList(
                    items: _cartItems,
                    onRemove: _removeItem,
                    onQuantityChanged: _updateQuantity,
                  ),
                ),
                CartCheckout(totalPrice: _totalPrice, cartItems: _cartItems),
              ],
            ),
    );
  }
}
