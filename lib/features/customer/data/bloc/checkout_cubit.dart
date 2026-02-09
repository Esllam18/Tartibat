import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/models/address_model.dart';
import 'package:tartibat/features/customer/data/models/cart_item_model.dart';
import 'package:tartibat/features/customer/data/models/order_model.dart';
import 'package:tartibat/features/customer/data/services/checkout_service.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutService _service;
  List<Address> _cachedAddresses = [];
  Address? _selectedAddress;
  String _selectedPayment = 'card';

  CheckoutCubit(this._service) : super(const CheckoutInitial()) {
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    try {
      emit(const CheckoutLoading());
      _cachedAddresses = await _service.getAddresses();

      if (_cachedAddresses.isNotEmpty) {
        _selectedAddress = _cachedAddresses.firstWhere(
          (a) => a.isDefault,
          orElse: () => _cachedAddresses.first,
        );

        emit(CheckoutReady(
          addresses: _cachedAddresses,
          selectedAddress: _selectedAddress,
          selectedPayment: _selectedPayment,
        ));
      } else {
        emit(CheckoutReady(
          addresses: [],
          selectedAddress: null,
          selectedPayment: _selectedPayment,
        ));
      }
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }

  void selectAddress(Address address) {
    _selectedAddress = address;
    emit(CheckoutReady(
      addresses: _cachedAddresses,
      selectedAddress: _selectedAddress,
      selectedPayment: _selectedPayment,
    ));
  }

  void selectPaymentMethod(String method) {
    _selectedPayment = method;
    if (_selectedAddress != null) {
      emit(CheckoutReady(
        addresses: _cachedAddresses,
        selectedAddress: _selectedAddress,
        selectedPayment: _selectedPayment,
      ));
    }
  }

  Future<void> saveAddress(Address address) async {
    try {
      final success = await _service.saveAddress(address);
      if (success) {
        emit(const AddressSaved());
        await loadAddresses();
      }
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }

  Future<void> placeOrder(List<CartItem> items, double total) async {
    try {
      if (_selectedAddress == null) {
        emit(const CheckoutError('Please select a delivery address'));
        return;
      }

      // Convert CartItem to OrderItem
      final orderItems = items.map((cartItem) {
        return OrderItem(
          productId: cartItem.productId,
          name: cartItem.name,
          nameAr: cartItem.nameAr,
          imageUrl: cartItem.imageUrl,
          quantity: cartItem.quantity,
          price: cartItem.price,
        );
      }).toList();

      final order = Order(
        id: 'ORD${DateTime.now().millisecondsSinceEpoch}',
        items: orderItems,
        address: _selectedAddress!,
        paymentMethod: _selectedPayment,
        total: total,
        createdAt: DateTime.now(),
        status: 'pending',
      );

      final success = await _service.placeOrder(order);
      if (success) {
        emit(OrderPlaced(order));
      } else {
        emit(const CheckoutError('Failed to place order'));
      }
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }

  List<Address> get addresses => _cachedAddresses;
  Address? get selectedAddress => _selectedAddress;
  String get selectedPayment => _selectedPayment;
}
