import 'package:equatable/equatable.dart';
import '../../customer/data/models/product_model.dart';

abstract class MerchantProductsState extends Equatable {
  const MerchantProductsState();

  @override
  List<Object?> get props => [];
}

class MerchantProductsInitial extends MerchantProductsState {
  const MerchantProductsInitial();
}

class MerchantProductsLoading extends MerchantProductsState {
  const MerchantProductsLoading();
}

class MerchantProductsLoaded extends MerchantProductsState {
  final List<Product> products;

  const MerchantProductsLoaded(this.products);

  int get totalProducts => products.length;
  int get activeProducts => products.where((p) => p.isAvailable).length;

  @override
  List<Object?> get props => [products];
}

class MerchantProductsError extends MerchantProductsState {
  final String message;

  const MerchantProductsError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductAdded extends MerchantProductsState {
  const ProductAdded();
}

class ProductUpdated extends MerchantProductsState {
  const ProductUpdated();
}

class ProductDeleted extends MerchantProductsState {
  const ProductDeleted();
}
