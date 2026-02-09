import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tartibat/features/customer/data/models/order_model.dart';

class MerchantOrdersService {
  static const String _ordersKey = 'merchant_orders';
  static MerchantOrdersService? _instance;
  SharedPreferences? _prefs;

  MerchantOrdersService._();

  static Future<MerchantOrdersService> getInstance() async {
    _instance ??= MerchantOrdersService._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<List<Order>> getOrders() async {
    try {
      final String? json = _prefs?.getString(_ordersKey);
      if (json == null || json.isEmpty) return [];
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((item) => Order.fromJson(item)).toList();
    } catch (e) {
      print('Error loading orders: $e');
      return [];
    }
  }

  Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    try {
      final orders = await getOrders();
      final index = orders.indexWhere((o) => o.id == orderId);
      if (index != -1) {
        final updatedOrder = Order(
          id: orders[index].id,
          items: orders[index].items,
          address: orders[index].address,
          paymentMethod: orders[index].paymentMethod,
          total: orders[index].total,
          createdAt: orders[index].createdAt,
          status: newStatus,
        );
        orders[index] = updatedOrder;
        return await _saveOrders(orders);
      }
      return false;
    } catch (e) {
      print('Error updating order status: $e');
      return false;
    }
  }

  Future<bool> _saveOrders(List<Order> orders) async {
    try {
      final encoded = jsonEncode(orders.map((o) => o.toJson()).toList());
      return await _prefs?.setString(_ordersKey, encoded) ?? false;
    } catch (e) {
      print('Error saving orders: $e');
      return false;
    }
  }
}
