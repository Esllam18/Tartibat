import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/customer/data/models/order_model.dart';

class SharedOrdersService {
  static const String _ordersKey = 'shared_orders';
  static SharedOrdersService? _instance;
  SharedPreferences? _prefs;

  SharedOrdersService._();

  static Future<SharedOrdersService> getInstance() async {
    _instance ??= SharedOrdersService._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // Get all orders
  Future<List<Order>> getAllOrders() async {
    try {
      final String? json = _prefs?.getString(_ordersKey);
      if (json == null || json.isEmpty) return [];

      final List<dynamic> decoded = jsonDecode(json);
      return decoded
          .map((item) => Order.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Error loading orders: $e');
      return [];
    }
  }

  // Save all orders
  Future<bool> saveOrders(List<Order> orders) async {
    try {
      final encoded = jsonEncode(orders.map((o) => o.toJson()).toList());
      final success = await _prefs?.setString(_ordersKey, encoded) ?? false;
      print('✅ Orders saved: ${orders.length} orders');
      return success;
    } catch (e) {
      print('❌ Error saving orders: $e');
      return false;
    }
  }

  // Add new order
  Future<bool> addOrder(Order order) async {
    try {
      final orders = await getAllOrders();
      orders.insert(0, order); // Add at beginning
      return await saveOrders(orders);
    } catch (e) {
      print('❌ Error adding order: $e');
      return false;
    }
  }

  // Update order status
  Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    try {
      final orders = await getAllOrders();
      final index = orders.indexWhere((o) => o.id == orderId);

      if (index == -1) {
        print('❌ Order not found: $orderId');
        return false;
      }

      // Create updated order with new status
      final oldOrder = orders[index];
      final updatedOrder = Order(
        id: oldOrder.id,
        items: oldOrder.items,
        address: oldOrder.address,
        paymentMethod: oldOrder.paymentMethod,
        total: oldOrder.total,
        createdAt: oldOrder.createdAt,
        status: newStatus,
      );

      orders[index] = updatedOrder;
      final success = await saveOrders(orders);

      if (success) {
        print('✅ Order $orderId status updated: $newStatus');
      }

      return success;
    } catch (e) {
      print('❌ Error updating order status: $e');
      return false;
    }
  }

  // Get order by ID
  Future<Order?> getOrderById(String orderId) async {
    try {
      final orders = await getAllOrders();
      return orders.firstWhere(
        (o) => o.id == orderId,
        orElse: () => throw Exception('Order not found'),
      );
    } catch (e) {
      print('❌ Error getting order: $e');
      return null;
    }
  }

  // Clear all orders
  Future<bool> clearOrders() async {
    try {
      return await _prefs?.remove(_ordersKey) ?? false;
    } catch (e) {
      print('❌ Error clearing orders: $e');
      return false;
    }
  }
}
