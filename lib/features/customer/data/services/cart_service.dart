import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item_model.dart';

class CartService {
  static const String _key = 'user_cart';
  static CartService? _instance;
  SharedPreferences? _prefs;

  CartService._();

  static Future<CartService> getInstance() async {
    _instance ??= CartService._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<List<CartItem>> getCartItems() async {
    try {
      final String? cartJson = _prefs?.getString(_key);
      if (cartJson == null || cartJson.isEmpty) return [];

      final List<dynamic> decoded = jsonDecode(cartJson);
      return decoded.map((item) => CartItem.fromJson(item)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addItem(CartItem item) async {
    try {
      final items = await getCartItems();
      final existingIndex =
          items.indexWhere((i) => i.productId == item.productId);

      if (existingIndex != -1) {
        items[existingIndex] = items[existingIndex].copyWith(
          quantity: items[existingIndex].quantity + item.quantity,
        );
      } else {
        items.add(item);
      }

      final success = await _saveCart(items);
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateQuantity(String productId, int quantity) async {
    try {
      final items = await getCartItems();
      final index = items.indexWhere((i) => i.productId == productId);

      if (index != -1) {
        if (quantity <= 0) {
          items.removeAt(index);
        } else {
          items[index] = items[index].copyWith(quantity: quantity);
        }
        return await _saveCart(items);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeItem(String productId) async {
    try {
      final items = await getCartItems();
      items.removeWhere((i) => i.productId == productId);
      return await _saveCart(items);
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearCart() async {
    try {
      return await _prefs?.remove(_key) ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _saveCart(List<CartItem> items) async {
    try {
      final String encoded = jsonEncode(items.map((i) => i.toJson()).toList());
      final success = await _prefs?.setString(_key, encoded) ?? false;
      return success;
    } catch (e) {
      return false;
    }
  }
}
