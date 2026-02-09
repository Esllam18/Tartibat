import 'package:equatable/equatable.dart';
import 'package:tartibat/features/customer/data/models/address_model.dart';
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
  final List<Address> addresses;
  final Address? selectedAddress;
  final String selectedPayment;

  const CheckoutReady({
    required this.addresses,
    required this.selectedAddress,
    required this.selectedPayment,
  });

  // ✅ Add this getter
  bool get canPlaceOrder =>
      selectedAddress != null && selectedPayment.isNotEmpty;

  @override
  List<Object?> get props => [addresses, selectedAddress, selectedPayment];
}

class AddressSaved extends CheckoutState {
  const AddressSaved();
}

class AddressUpdated extends CheckoutState {
  const AddressUpdated();
}

class AddressDeleted extends CheckoutState {
  const AddressDeleted();
}

class OrderPlaced extends CheckoutState {
  final Order order;

  const OrderPlaced(this.order);

  @override
  List<Object?> get props => [order];
}

class CheckoutError extends CheckoutState {
  final String message;

  const CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}
