import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/models/user_model.dart';
import 'package:tartibat/features/customer/data/services/profile_service.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService _service;
  UserModel? _currentUser;

  ProfileCubit(this._service) : super(const ProfileInitial()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      emit(const ProfileLoading());
      _currentUser = await _service.getUserProfile();
      if (_currentUser != null) {
        emit(ProfileLoaded(_currentUser!));
      } else {
        emit(const ProfileError('Failed to load profile'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile(UserModel user) async {
    try {
      final success = await _service.saveUserProfile(user);
      if (success) {
        _currentUser = user;
        emit(const ProfileUpdated());
        emit(ProfileLoaded(user));
      } else {
        emit(const ProfileError('Failed to update profile'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _service.clearProfile();
      emit(const ProfileLoggedOut());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  UserModel? get currentUser => _currentUser;
}
