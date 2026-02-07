import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/checkout/checkout_app_bar.dart';
import '../widgets/checkout/delivery_address_section.dart';
import '../widgets/checkout/payment_method_section.dart';
import '../widgets/checkout/order_summary_section.dart';
import '../widgets/checkout/checkout_bottom_bar.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedAddress = '';

  int get _subtotal => widget.cartItems.fold(
        0,
        (sum, item) =>
            sum + ((item['price'] as int) * (item['quantity'] as int)),
      );

  int get _deliveryFee => 5000; // Fixed delivery fee in IQD

  int get _total => _subtotal + _deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CheckoutAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DeliveryAddressSection(
              selectedAddress: _selectedAddress,
              onAddressChanged: (address) {
                setState(() => _selectedAddress = address);
              },
            ),
            const SizedBox(height: 16),
            const PaymentMethodSection(),
            const SizedBox(height: 16),
            OrderSummarySection(
              items: widget.cartItems,
              subtotal: _subtotal,
              deliveryFee: _deliveryFee,
              total: _total,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: CheckoutBottomBar(totalPrice: _total),
    );
  }
}
