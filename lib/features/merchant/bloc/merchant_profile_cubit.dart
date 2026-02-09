import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/merchant_profile_model.dart';
import '../data/services/merchant_profile_service.dart';
import 'merchant_profile_state.dart';

class MerchantProfileCubit extends Cubit<MerchantProfileState> {
  final MerchantProfileService _service;
  MerchantProfile? _currentProfile;

  MerchantProfileCubit(this._service) : super(const MerchantProfileInitial()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      emit(const MerchantProfileLoading());
      _currentProfile = await _service.getProfile();
      if (_currentProfile != null) {
        emit(MerchantProfileLoaded(_currentProfile!));
      } else {
        emit(const MerchantProfileError('Failed to load profile'));
      }
    } catch (e) {
      emit(MerchantProfileError(e.toString()));
    }
  }

  Future<void> updateProfile(MerchantProfile profile) async {
    try {
      final success = await _service.saveProfile(profile);
      if (success) {
        _currentProfile = profile;
        emit(const MerchantProfileUpdated());
        emit(MerchantProfileLoaded(profile));
      } else {
        emit(const MerchantProfileError('Failed to update profile'));
      }
    } catch (e) {
      emit(MerchantProfileError(e.toString()));
    }
  }

  Future<void> updateEarnings(double amount) async {
    try {
      final success = await _service.updateEarnings(amount);
      if (success) {
        await loadProfile();
      }
    } catch (e) {
      emit(MerchantProfileError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _service.clearProfile();
      emit(const MerchantProfileLoggedOut());
    } catch (e) {
      emit(MerchantProfileError(e.toString()));
    }
  }

  MerchantProfile? get currentProfile => _currentProfile;
}
