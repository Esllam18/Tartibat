import 'package:shared_preferences/shared_preferences.dart';

class RoleCacheHelper {
  static const String _roleKey = 'selected_role';

  Future<String> getSelectedRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey) ?? '';
  }

  Future<void> saveSelectedRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
  }

  Future<bool> hasSelectedRole() async {
    final role = await getSelectedRole();
    return role.isNotEmpty;
  }

  Future<void> clearRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_roleKey);
  }
}
