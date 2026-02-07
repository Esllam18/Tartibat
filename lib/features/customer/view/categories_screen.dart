import 'package:flutter/material.dart';
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
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'كنبة مودرن فاخرة',
      'price': 4500,
      'quantity': 1,
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
    },
    {
      'name': 'طاولة طعام خشبية',
      'price': 3200,
      'quantity': 2,
      'image':
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=400',
    },
    {
      'name': 'كرسي مكتب جلد',
      'price': 1200,
      'quantity': 1,
      'image':
          'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=400',
    },
  ];

  int get _totalPrice => _cartItems.fold(
        0,
        (sum, item) =>
            sum + ((item['price'] as int) * (item['quantity'] as int)),
      );

  void _removeItem(int index) => setState(() => _cartItems.removeAt(index));
  void _clearCart() => setState(() => _cartItems.clear());
  void _updateQuantity(int index, int newQuantity) =>
      setState(() => _cartItems[index]['quantity'] = newQuantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
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
                CartCheckout(totalPrice: _totalPrice, cartItems: const []),
              ],
            ),
    );
  }
}
