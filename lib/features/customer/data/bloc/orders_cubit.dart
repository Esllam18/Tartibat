import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/services/orders_service.dart';

import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersService _service;

  OrdersCubit(this._service) : super(const OrdersInitial());

  Future<void> loadOrders() async {
    try {
      emit(const OrdersLoading());
      final orders = await _service.getOrders();

      if (orders.isEmpty) {
        emit(const OrdersEmpty());
      } else {
        emit(OrdersLoaded(orders));
      }
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> loadOrdersByStatus(String status) async {
    try {
      emit(const OrdersLoading());
      final orders = await _service.getOrdersByStatus(status);

      if (orders.isEmpty) {
        emit(const OrdersEmpty());
      } else {
        emit(OrdersLoaded(orders));
      }
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      emit(const OrdersLoading());
      final success = await _service.cancelOrder(orderId);

      if (success) {
        await loadOrders();
      } else {
        emit(const OrdersError('Failed to cancel order'));
      }
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> refresh() async {
    await loadOrders();
  }
}
