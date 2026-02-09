import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/models/cart_item_model.dart';
import 'package:tartibat/features/customer/data/models/delivery_address_model.dart';
import 'package:tartibat/features/customer/data/models/order_model.dart';
import 'package:tartibat/features/customer/data/services/checkout_service.dart';

import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutService _service;
  List<DeliveryAddress> _cachedAddresses = [];
  DeliveryAddress? _selectedAddress;
  final String _selectedPayment = 'card'; // ✅ Changed from 'cash' to 'card'

  CheckoutCubit(this._service) : super(const CheckoutInitial()) {
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    try {
      emit(const CheckoutLoading());
      _cachedAddresses = await _service.getAddresses();
      _selectedAddress = _cachedAddresses.firstWhere(
        (a) => a.isDefault,
        // ignore: cast_from_null_always_fails
        orElse: () => _cachedAddresses.isNotEmpty
            ? _cachedAddresses.first
            // ignore: cast_from_null_always_fails
            : null as DeliveryAddress,
      );
      emit(CheckoutReady(
        addresses: _cachedAddresses,
        selectedAddress: _selectedAddress,
        selectedPayment: _selectedPayment,
      ));
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }

  void selectAddress(DeliveryAddress address) {
    _selectedAddress = address;
    emit(CheckoutReady(
      addresses: _cachedAddresses,
      selectedAddress: _selectedAddress,
      selectedPayment: _selectedPayment,
    ));
  }

  Future<void> saveAddress(DeliveryAddress address) async {
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

      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        items: items,
        address: _selectedAddress!,
        paymentMethod: 'card',
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
}
