import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tartibat/features/customer/data/models/product_model.dart';

class MerchantProductsService {
  static const String _productsKey = 'merchant_products';
  static MerchantProductsService? _instance;
  SharedPreferences? _prefs;

  MerchantProductsService._();

  static Future<MerchantProductsService> getInstance() async {
    _instance ??= MerchantProductsService._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<List<Product>> getProducts() async {
    try {
      final String? json = _prefs?.getString(_productsKey);
      if (json == null || json.isEmpty) return [];
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((item) => Product.fromJson(item)).toList();
    } catch (e) {
      print('Error loading products: $e');
      return [];
    }
  }

  Future<bool> addProduct(Product product) async {
    try {
      final products = await getProducts();
      products.add(product);
      return await _saveProducts(products);
    } catch (e) {
      print('Error adding product: $e');
      return false;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      final products = await getProducts();
      final index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = product;
        return await _saveProducts(products);
      }
      return false;
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      final products = await getProducts();
      products.removeWhere((p) => p.id == productId);
      return await _saveProducts(products);
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }

  Future<bool> _saveProducts(List<Product> products) async {
    try {
      final encoded = jsonEncode(products.map((p) => p.toJson()).toList());
      return await _prefs?.setString(_productsKey, encoded) ?? false;
    } catch (e) {
      print('Error saving products: $e');
      return false;
    }
  }
}
