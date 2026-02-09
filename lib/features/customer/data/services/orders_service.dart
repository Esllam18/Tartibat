import '../../../../core/services/shared_orders_service.dart';
import '../models/order_model.dart';

class OrdersService {
  static OrdersService? _instance;
  late final SharedOrdersService _sharedService;

  OrdersService._(this._sharedService);

  static Future<OrdersService> getInstance() async {
    if (_instance == null) {
      final sharedService = await SharedOrdersService.getInstance();
      _instance = OrdersService._(sharedService);
    }
    return _instance!;
  }

  // Get all orders
  Future<List<Order>> getOrders() async {
    return await _sharedService.getAllOrders();
  }

  // Get order by ID
  Future<Order?> getOrderById(String orderId) async {
    return await _sharedService.getOrderById(orderId);
  }

  // Get orders by status
  Future<List<Order>> getOrdersByStatus(String status) async {
    final orders = await getOrders();
    return orders.where((order) => order.status == status).toList();
  }

  // Cancel order
  Future<bool> cancelOrder(String orderId) async {
    return await _sharedService.updateOrderStatus(orderId, 'cancelled');
  }
}
