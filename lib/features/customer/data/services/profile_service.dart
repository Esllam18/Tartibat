import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class ProfileService {
  static const String _userKey = 'user_profile';
  static ProfileService? _instance;
  SharedPreferences? _prefs;

  ProfileService._();

  static Future<ProfileService> getInstance() async {
    _instance ??= ProfileService._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<UserModel?> getUserProfile() async {
    try {
      final String? json = _prefs?.getString(_userKey);
      if (json == null || json.isEmpty) {
        // Return default user if none exists
        return UserModel(
          id: '1',
          name: 'Guest User',
          email: 'guest@example.com',
          phone: '+20 123 456 7890',
        );
      }
      return UserModel.fromJson(jsonDecode(json));
    } catch (e) {
      print('Error loading profile: $e');
      return null;
    }
  }

  Future<bool> saveUserProfile(UserModel user) async {
    try {
      final encoded = jsonEncode(user.toJson());
      final success = await _prefs?.setString(_userKey, encoded) ?? false;
      print('Profile saved: ${user.name}, Success: $success');
      return success;
    } catch (e) {
      print('Error saving profile: $e');
      return false;
    }
  }

  Future<bool> clearProfile() async {
    try {
      return await _prefs?.remove(_userKey) ?? false;
    } catch (e) {
      print('Error clearing profile: $e');
      return false;
    }
  }
}
