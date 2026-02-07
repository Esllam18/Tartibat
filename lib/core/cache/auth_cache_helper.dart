import 'package:shared_preferences/shared_preferences.dart';

class AuthCacheHelper {
  static const String _tokenKey = 'auth_token';
  static const String _roleKey = 'user_role';
  static const String _isApprovedKey = 'is_trader_approved';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';

  Future<void> saveAuthData({
    required String token,
    required String role,
    required String userName,
    required String userEmail,
    bool isTraderApproved = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_roleKey, role);
    await prefs.setBool(_isApprovedKey, isTraderApproved);
    await prefs.setString(_userNameKey, userName);
    await prefs.setString(_userEmailKey, userEmail);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_tokenKey);
  }

  Future<String> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey) ?? '';
  }

  Future<bool> isTraderApproved() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isApprovedKey) ?? false;
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey) ?? '';
  }

  Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey) ?? '';
  }

  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_roleKey);
    await prefs.remove(_isApprovedKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_userEmailKey);
  }
}
