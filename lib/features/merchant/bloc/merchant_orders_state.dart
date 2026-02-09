import 'package:equatable/equatable.dart';
import '../../customer/data/models/order_model.dart';

abstract class MerchantOrdersState extends Equatable {
  const MerchantOrdersState();

  @override
  List<Object?> get props => [];
}

class MerchantOrdersInitial extends MerchantOrdersState {
  const MerchantOrdersInitial();
}

class MerchantOrdersLoading extends MerchantOrdersState {
  const MerchantOrdersLoading();
}

class MerchantOrdersLoaded extends MerchantOrdersState {
  final List<Order> orders;

  const MerchantOrdersLoaded(this.orders);

  int get totalOrders => orders.length;
  int get pendingOrders => orders
      .where((o) => o.status == 'pending' || o.status == 'confirmed')
      .length;
  int get completedOrders =>
      orders.where((o) => o.status == 'delivered').length;
  double get totalRevenue =>
      orders.fold(0.0, (sum, order) => sum + order.total);

  @override
  List<Object?> get props => [orders];
}

class MerchantOrdersError extends MerchantOrdersState {
  final String message;

  const MerchantOrdersError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderStatusUpdated extends MerchantOrdersState {
  const OrderStatusUpdated();
}
