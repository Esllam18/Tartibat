import 'package:equatable/equatable.dart';
import '../data/models/merchant_profile_model.dart';

abstract class MerchantProfileState extends Equatable {
  const MerchantProfileState();

  @override
  List<Object?> get props => [];
}

class MerchantProfileInitial extends MerchantProfileState {
  const MerchantProfileInitial();
}

class MerchantProfileLoading extends MerchantProfileState {
  const MerchantProfileLoading();
}

class MerchantProfileLoaded extends MerchantProfileState {
  final MerchantProfile profile;

  const MerchantProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class MerchantProfileError extends MerchantProfileState {
  final String message;

  const MerchantProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class MerchantProfileUpdated extends MerchantProfileState {
  const MerchantProfileUpdated();
}

class MerchantProfileLoggedOut extends MerchantProfileState {
  const MerchantProfileLoggedOut();
}
