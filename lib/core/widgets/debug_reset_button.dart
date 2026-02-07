import 'package:flutter/material.dart';
import 'package:tartibat/core/cache/auth_cache_helper.dart';
import 'package:tartibat/core/cache/onboarding_cache_helper.dart';
import 'package:tartibat/core/cache/role_cache_helper.dart';
import 'package:tartibat/core/localization/language_cache_helper.dart';

class DebugResetButton extends StatelessWidget {
  const DebugResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 20,
      child: GestureDetector(
        onTap: () async {
          await AuthCacheHelper().clearAuthData();
          await RoleCacheHelper().clearRole();
          await LanguageCacheHelper().clearLanguage();
          await OnboardingCacheHelper().resetOnboarding();
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('🧹 Cache cleared!')),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.refresh, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
