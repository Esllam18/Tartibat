import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/delivery_address_model.dart';
import '../models/order_model.dart';

class CheckoutService {
  static const String _addressKey = 'delivery_addresses';
  static const String _ordersKey = 'user_orders';
  static CheckoutService? _instance;
  SharedPreferences? _prefs;

  CheckoutService._();

  static Future<CheckoutService> getInstance() async {
    _instance ??= CheckoutService._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<List<DeliveryAddress>> getAddresses() async {
    try {
      final String? json = _prefs?.getString(_addressKey);
      if (json == null || json.isEmpty) return [];
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((item) => DeliveryAddress.fromJson(item)).toList();
    } catch (e) {
      print('Error loading addresses: $e');
      return [];
    }
  }

  Future<bool> saveAddress(DeliveryAddress address) async {
    try {
      final addresses = await getAddresses();
      addresses.add(address);
      final encoded = jsonEncode(addresses.map((a) => a.toJson()).toList());
      return await _prefs?.setString(_addressKey, encoded) ?? false;
    } catch (e) {
      print('Error saving address: $e');
      return false;
    }
  }

  Future<bool> placeOrder(Order order) async {
    try {
      final orders = await getOrders();
      orders.insert(0, order);
      final encoded = jsonEncode(orders.map((o) => o.toJson()).toList());
      final success = await _prefs?.setString(_ordersKey, encoded) ?? false;
      print('Order placed: ${order.id}, Success: $success');
      return success;
    } catch (e) {
      print('Error placing order: $e');
      return false;
    }
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
}
