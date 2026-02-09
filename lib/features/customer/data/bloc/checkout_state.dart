import 'package:equatable/equatable.dart';
import 'package:tartibat/features/customer/data/models/delivery_address_model.dart';
import 'package:tartibat/features/customer/data/models/order_model.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();
}

class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

class CheckoutReady extends CheckoutState {
  final List<DeliveryAddress> addresses;
  final DeliveryAddress? selectedAddress;
  final String selectedPayment;

  const CheckoutReady({
    required this.addresses,
    this.selectedAddress,
    this.selectedPayment = 'cash',
  });

  bool get canPlaceOrder => selectedAddress != null;

  CheckoutReady copyWith({
    List<DeliveryAddress>? addresses,
    DeliveryAddress? selectedAddress,
    String? selectedPayment,
  }) {
    return CheckoutReady(
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedPayment: selectedPayment ?? this.selectedPayment,
    );
  }

  @override
  List<Object?> get props => [addresses, selectedAddress, selectedPayment];
}

class CheckoutError extends CheckoutState {
  final String message;

  const CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderPlaced extends CheckoutState {
  final Order order;

  const OrderPlaced(this.order);

  @override
  List<Object?> get props => [order];
}

class AddressSaved extends CheckoutState {
  const AddressSaved();
}
