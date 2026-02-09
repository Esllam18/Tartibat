import 'package:tartibat/features/customer/data/models/order_model.dart';

import '../../../../core/services/shared_orders_service.dart';

class MerchantOrdersService {
  static MerchantOrdersService? _instance;
  late final SharedOrdersService _sharedService;

  MerchantOrdersService._(this._sharedService);

  static Future<MerchantOrdersService> getInstance() async {
    if (_instance == null) {
      final sharedService = await SharedOrdersService.getInstance();
      _instance = MerchantOrdersService._(sharedService);
    }
    return _instance!;
  }

  Future<List<Order>> getOrders() async {
    return await _sharedService.getAllOrders();
  }

  // ✅ This is crucial for status updates
  Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    final success = await _sharedService.updateOrderStatus(orderId, newStatus);
    if (success) {
      print('✅ Order $orderId updated to: $newStatus');
    }
    return success;
  }

  Future<Order?> getOrderById(String orderId) async {
    return await _sharedService.getOrderById(orderId);
  }
}
