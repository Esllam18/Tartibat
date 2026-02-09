import 'package:equatable/equatable.dart';
import 'package:tartibat/features/customer/data/models/cart_item_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<CartItem> items;

  const CartLoaded(this.items);

  int get itemCount => items.length; // ✅ Number of unique items
  int get totalQuantity =>
      items.fold(0, (sum, item) => sum + item.quantity); // Total quantity
  bool get isEmpty => items.isEmpty;

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.total);
  double get total => subtotal; // ✅ Just subtotal, no tax/shipping

  bool isInCart(String productId) {
    return items.any((item) => item.productId == productId);
  }

  @override
  List<Object?> get props => [items];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}

class CartItemAdded extends CartState {
  final String productName;

  const CartItemAdded(this.productName);

  @override
  List<Object?> get props => [productName];
}

class CartItemRemoved extends CartState {
  final String productName;

  const CartItemRemoved(this.productName);

  @override
  List<Object?> get props => [productName];
}
