import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../customer/data/models/product_model.dart';

class MerchantProductsService {
  static const String _productsKey = 'products';
  static MerchantProductsService? _instance;
  SharedPreferences? _prefs;

  MerchantProductsService._();

  static Future<MerchantProductsService> getInstance() async {
    _instance ??= MerchantProductsService._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // Get all products
  Future<List<Product>> getProducts() async {
    try {
      final String? json = _prefs?.getString(_productsKey);

      if (json == null || json.isEmpty) {
        print('⚠️ No products found in SharedPreferences');
        return [];
      }

      final List<dynamic> decoded = jsonDecode(json);
      final products = decoded
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();

      print('✅ MerchantProductsService: Loaded ${products.length} products');
      for (var product in products) {
        print('   - ${product.name} (\$${product.price})');
      }

      return products;
    } catch (e) {
      print('❌ Error loading products: $e');
      return [];
    }
  }

  // Save products
  Future<bool> _saveProducts(List<Product> products) async {
    try {
      final encoded = jsonEncode(products.map((p) => p.toJson()).toList());
      final success = await _prefs?.setString(_productsKey, encoded) ?? false;

      if (success) {
        print('✅ Saved ${products.length} products to storage');
      }

      return success;
    } catch (e) {
      print('❌ Error saving products: $e');
      return false;
    }
  }

  // Add product
  Future<bool> addProduct(Product product) async {
    try {
      final products = await getProducts();
      products.insert(0, product);
      return await _saveProducts(products);
    } catch (e) {
      print('❌ Error adding product: $e');
      return false;
    }
  }

  // Update product
  Future<bool> updateProduct(Product product) async {
    try {
      final products = await getProducts();
      final index = products.indexWhere((p) => p.id == product.id);

      if (index == -1) {
        print('❌ Product not found: ${product.id}');
        return false;
      }

      products[index] = product;
      return await _saveProducts(products);
    } catch (e) {
      print('❌ Error updating product: $e');
      return false;
    }
  }

  // Delete product
  Future<bool> deleteProduct(String productId) async {
    try {
      final products = await getProducts();
      products.removeWhere((p) => p.id == productId);
      return await _saveProducts(products);
    } catch (e) {
      print('❌ Error deleting product: $e');
      return false;
    }
  }
}
