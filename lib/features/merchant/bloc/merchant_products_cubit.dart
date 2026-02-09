import 'package:flutter_bloc/flutter_bloc.dart';
import '../../customer/data/models/product_model.dart';
import '../data/services/merchant_products_service.dart';
import 'merchant_products_state.dart';

class MerchantProductsCubit extends Cubit<MerchantProductsState> {
  final MerchantProductsService _service;
  List<Product> _cachedProducts = [];

  MerchantProductsCubit(this._service)
      : super(const MerchantProductsInitial()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      emit(const MerchantProductsLoading());
      _cachedProducts = await _service.getProducts();
      emit(MerchantProductsLoaded(_cachedProducts));
    } catch (e) {
      emit(MerchantProductsError(e.toString()));
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final success = await _service.addProduct(product);
      if (success) {
        emit(const ProductAdded());
        await loadProducts();
      } else {
        emit(const MerchantProductsError('Failed to add product'));
      }
    } catch (e) {
      emit(MerchantProductsError(e.toString()));
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      final success = await _service.updateProduct(product);
      if (success) {
        emit(const ProductUpdated());
        await loadProducts();
      } else {
        emit(const MerchantProductsError('Failed to update product'));
      }
    } catch (e) {
      emit(MerchantProductsError(e.toString()));
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      final success = await _service.deleteProduct(productId);
      if (success) {
        emit(const ProductDeleted());
        await loadProducts();
      } else {
        emit(const MerchantProductsError('Failed to delete product'));
      }
    } catch (e) {
      emit(MerchantProductsError(e.toString()));
    }
  }

  List<Product> get products => _cachedProducts;
}
