import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/address_model.dart';
import '../models/order_model.dart';
import '../../../../core/services/shared_orders_service.dart';

class CheckoutService {
  static const String _addressesKey = 'saved_addresses';
  static CheckoutService? _instance;
  SharedPreferences? _prefs;
  SharedOrdersService? _sharedOrdersService;

  CheckoutService._();

  static Future<CheckoutService> getInstance() async {
    _instance ??= CheckoutService._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    _instance!._sharedOrdersService ??= await SharedOrdersService.getInstance();
    return _instance!;
  }

  // ✅ Get addresses - returns List<Address>
  Future<List<Address>> getAddresses() async {
    try {
      final String? json = _prefs?.getString(_addressesKey);
      if (json == null || json.isEmpty) return [];

      final List<dynamic> decoded = jsonDecode(json);
      return decoded
          .map((item) => Address.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading addresses: $e');
      return [];
    }
  }

  // ✅ Save address - accepts Address
  Future<bool> saveAddress(Address address) async {
    try {
      final addresses = await getAddresses();

      if (address.isDefault) {
        for (var i = 0; i < addresses.length; i++) {
          addresses[i] = addresses[i].copyWith(isDefault: false);
        }
      }

      addresses.add(address);
      return await _saveAddresses(addresses);
    } catch (e) {
      print('Error saving address: $e');
      return false;
    }
  }

  // ✅ Update address
  Future<bool> updateAddress(Address address) async {
    try {
      final addresses = await getAddresses();
      final index = addresses.indexWhere((a) => a.id == address.id);

      if (index == -1) return false;

      if (address.isDefault) {
        for (var i = 0; i < addresses.length; i++) {
          if (i != index) {
            addresses[i] = addresses[i].copyWith(isDefault: false);
          }
        }
      }

      addresses[index] = address;
      return await _saveAddresses(addresses);
    } catch (e) {
      print('Error updating address: $e');
      return false;
    }
  }

  // ✅ Delete address
  Future<bool> deleteAddress(String addressId) async {
    try {
      final addresses = await getAddresses();
      addresses.removeWhere((a) => a.id == addressId);
      return await _saveAddresses(addresses);
    } catch (e) {
      print('Error deleting address: $e');
      return false;
    }
  }

  Future<bool> _saveAddresses(List<Address> addresses) async {
    try {
      final encoded = jsonEncode(addresses.map((a) => a.toJson()).toList());
      return await _prefs?.setString(_addressesKey, encoded) ?? false;
    } catch (e) {
      print('Error saving addresses: $e');
      return false;
    }
  }

  // ✅ Place order
  Future<bool> placeOrder(Order order) async {
    try {
      if (_sharedOrdersService == null) {
        _sharedOrdersService = await SharedOrdersService.getInstance();
      }

      return await _sharedOrdersService!.addOrder(order);
    } catch (e) {
      print('Error placing order: $e');
      return false;
    }
  }
}
