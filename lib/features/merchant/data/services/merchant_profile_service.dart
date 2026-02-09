import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/merchant_profile_model.dart';

class MerchantProfileService {
  static const String _profileKey = 'merchant_profile';
  static MerchantProfileService? _instance;
  SharedPreferences? _prefs;

  MerchantProfileService._();

  static Future<MerchantProfileService> getInstance() async {
    _instance ??= MerchantProfileService._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<MerchantProfile?> getProfile() async {
    try {
      final String? json = _prefs?.getString(_profileKey);
      if (json == null || json.isEmpty) {
        // Return default merchant profile
        return MerchantProfile(
          id: '1',
          storeName: 'My Store',
          storeNameAr: 'متجري',
          ownerName: 'Store Owner',
          email: 'store@example.com',
          phone: '+20 123 456 7890',
          totalEarnings: 15000.0,
          totalProductsSold: 156,
          totalOrdersHandled: 89,
        );
      }
      return MerchantProfile.fromJson(jsonDecode(json));
    } catch (e) {
      print('Error loading merchant profile: $e');
      return null;
    }
  }

  Future<bool> saveProfile(MerchantProfile profile) async {
    try {
      final encoded = jsonEncode(profile.toJson());
      final success = await _prefs?.setString(_profileKey, encoded) ?? false;
      print('Merchant profile saved: ${profile.storeName}, Success: $success');
      return success;
    } catch (e) {
      print('Error saving merchant profile: $e');
      return false;
    }
  }

  Future<bool> updateEarnings(double amount) async {
    try {
      final profile = await getProfile();
      if (profile != null) {
        final updated = profile.copyWith(
          totalEarnings: profile.totalEarnings + amount,
        );
        return await saveProfile(updated);
      }
      return false;
    } catch (e) {
      print('Error updating earnings: $e');
      return false;
    }
  }

  Future<bool> clearProfile() async {
    try {
      return await _prefs?.remove(_profileKey) ?? false;
    } catch (e) {
      print('Error clearing merchant profile: $e');
      return false;
    }
  }
}
