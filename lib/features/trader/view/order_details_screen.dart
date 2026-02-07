import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';
import '../widgets/orders/order_details_header.dart';
import '../widgets/orders/customer_info_section.dart';
import '../widgets/orders/order_products_section.dart';
import '../widgets/orders/order_status_section.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          '${'order'.tr(context)} #${order['id']}',
          style: TextStyle(
              color: Colors.black,
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(r.spacing(16)),
        child: Column(
          children: [
            OrderDetailsHeader(order: order),
            SizedBox(height: r.spacing(16)),
            CustomerInfoSection(customer: order['customerInfo'] ?? {}),
            SizedBox(height: r.spacing(16)),
            OrderProductsSection(products: order['products'] ?? []),
            SizedBox(height: r.spacing(16)),
            OrderStatusSection(
              currentStatus: order['status'] ?? 'preparing',
              onStatusChange: (status) {},
            ),
          ],
        ),
      ),
    );
  }
}
