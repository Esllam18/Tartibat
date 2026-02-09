import 'package:flutter_bloc/flutter_bloc.dart';
import '../../customer/data/models/order_model.dart';
import '../data/services/merchant_orders_service.dart';
import 'merchant_orders_state.dart';

class MerchantOrdersCubit extends Cubit<MerchantOrdersState> {
  final MerchantOrdersService _service;
  List<Order> _cachedOrders = [];

  MerchantOrdersCubit(this._service) : super(const MerchantOrdersInitial()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      emit(const MerchantOrdersLoading());
      _cachedOrders = await _service.getOrders();
      _cachedOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(MerchantOrdersLoaded(_cachedOrders));
    } catch (e) {
      emit(MerchantOrdersError(e.toString()));
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      final success = await _service.updateOrderStatus(orderId, newStatus);
      if (success) {
        emit(const OrderStatusUpdated());
        await loadOrders();
      } else {
        emit(const MerchantOrdersError('Failed to update order status'));
      }
    } catch (e) {
      emit(MerchantOrdersError(e.toString()));
    }
  }

  List<Order> getOrdersByStatus(String status) {
    return _cachedOrders.where((order) => order.status == status).toList();
  }

  List<Order> getPendingOrders() {
    return _cachedOrders
        .where((order) =>
            order.status == 'pending' ||
            order.status == 'confirmed' ||
            order.status == 'processing')
        .toList();
  }

  List<Order> get orders => _cachedOrders;
}
