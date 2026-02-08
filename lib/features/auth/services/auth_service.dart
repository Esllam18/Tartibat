import 'package:flutter/material.dart';
import '../../../core/cache/auth_cache_helper.dart';
import '../../role_selection/view/role_selection_screen.dart';
import '../../customer/view/main_navigation_screen.dart';
import '../../trader/view/trader_main_layout.dart';

class AuthService {
  // ignore: unused_field
  static const String _baseUrl = 'https://api.tartibat.com';

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      // final response = await http.post(
      //   Uri.parse('$_baseUrl/auth/login'),
      //   body: {'email': email, 'password': password},
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock response: Get user role from backend
      final role = email.contains('trader') ? 'trader' : 'customer';
      final token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';

      await AuthCacheHelper().saveAuthData(
        token: token,
        role: role,
        userName: 'User',
        userEmail: email,
        isTraderApproved: true,
      );

      // Navigate based on role
      final context = navigatorKey.currentContext!;
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (_) => role == 'trader'
              ? const TraderMainLayout()
              : const CustomerMainLayout(),
        ),
        (_) => false,
      );
    } catch (e) {
      throw 'Login failed: ${e.toString()}';
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      // final response = await http.post(
      //   Uri.parse('$_baseUrl/auth/register'),
      //   body: {
      //     'name': name,
      //     'email': email,
      //     'phone': phone,
      //     'password': password,
      //   },
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // After registration, go to role selection
      final context = navigatorKey.currentContext!;
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (_) => RoleSelectionScreen(
            userName: name,
            userEmail: email,
            userPhone: phone,
          ),
        ),
      );
    } catch (e) {
      throw 'Registration failed: ${e.toString()}';
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw 'Failed to send reset email: ${e.toString()}';
    }
  }
}

// Global navigator key (add to main.dart)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
