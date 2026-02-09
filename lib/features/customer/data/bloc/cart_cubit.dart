import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/models/cart_item_model.dart';
import 'package:tartibat/features/customer/data/models/product_model.dart';
import 'package:tartibat/features/customer/data/services/cart_service.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartService _service;
  List<CartItem> _cachedItems = [];

  CartCubit(this._service) : super(const CartInitial()) {
    loadCart();
  }

  Future<void> loadCart() async {
    try {
      emit(const CartLoading());
      _cachedItems = await _service.getCartItems();
      emit(CartLoaded(List.from(_cachedItems)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addToCart(Product product, int quantity) async {
    try {
      final cartItem = CartItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        productId: product.id,
        name: product.name,
        nameAr: product.nameAr,
        price: product.price,
        imageUrl: product.imageUrl,
        merchant: product.merchant,
        quantity: quantity,
        addedAt: DateTime.now(),
      );

      final success = await _service.addItem(cartItem);

      if (success) {
        _cachedItems = await _service.getCartItems();
        emit(CartLoaded(List.from(_cachedItems)));
        emit(CartItemAdded(product.name));
        emit(CartLoaded(List.from(_cachedItems)));
      }
    } catch (e) {
      emit(CartError(e.toString()));
      emit(CartLoaded(List.from(_cachedItems)));
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    try {
      final success = await _service.updateQuantity(productId, quantity);

      if (success) {
        _cachedItems = await _service.getCartItems();
        emit(CartLoaded(List.from(_cachedItems)));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> removeItem(String productId) async {
    try {
      final item = _cachedItems.firstWhere((i) => i.productId == productId);
      final success = await _service.removeItem(productId);

      if (success) {
        _cachedItems.removeWhere((i) => i.productId == productId);
        emit(CartLoaded(List.from(_cachedItems)));
        emit(CartItemRemoved(item.name));
        emit(CartLoaded(List.from(_cachedItems)));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> clearCart() async {
    try {
      await _service.clearCart();
      _cachedItems.clear();
      emit(CartLoaded(const []));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  int getItemCount() {
    return _cachedItems.fold(0, (sum, item) => sum + item.quantity);
  }
}
