import 'package:flutter_bloc/flutter_bloc.dart';
import '../../customer/data/models/product_model.dart';
import '../data/services/merchant_products_service.dart';
import 'merchant_products_state.dart';

class MerchantProductsCubit extends Cubit<MerchantProductsState> {
  final MerchantProductsService _service;

  MerchantProductsCubit(this._service)
      : super(const MerchantProductsInitial()) {
    // ✅ Load products on initialization
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      print('🔄 Loading products...');
      emit(const MerchantProductsLoading());

      final products = await _service.getProducts();

      print('✅ Loaded ${products.length} products from storage');
      emit(MerchantProductsLoaded(products));
    } catch (e) {
      print('❌ Error loading products: $e');
      emit(MerchantProductsError(e.toString()));
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      emit(const MerchantProductsLoading());
      final success = await _service.addProduct(product);

      if (success) {
        print('✅ Product added: ${product.name}');
        emit(const ProductAdded());
        await loadProducts();
      } else {
        emit(const MerchantProductsError('Failed to add product'));
      }
    } catch (e) {
      print('❌ Error adding product: $e');
      emit(MerchantProductsError(e.toString()));
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      emit(const MerchantProductsLoading());
      final success = await _service.updateProduct(product);

      if (success) {
        print('✅ Product updated: ${product.name}');
        emit(const ProductUpdated());
        await loadProducts();
      } else {
        emit(const MerchantProductsError('Failed to update product'));
      }
    } catch (e) {
      print('❌ Error updating product: $e');
      emit(MerchantProductsError(e.toString()));
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      emit(const MerchantProductsLoading());
      final success = await _service.deleteProduct(productId);

      if (success) {
        print('✅ Product deleted: $productId');
        emit(const ProductDeleted());
        await loadProducts();
      } else {
        emit(const MerchantProductsError('Failed to delete product'));
      }
    } catch (e) {
      print('❌ Error deleting product: $e');
      emit(MerchantProductsError(e.toString()));
    }
  }

  Future<void> refresh() async {
    print('🔄 Refreshing products...');
    await loadProducts();
  }
}
