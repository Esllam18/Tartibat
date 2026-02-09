import 'package:flutter/material.dart';

import '../../../core/cache/auth_cache_helper.dart';
import '../../../core/cache/language_cache_helper.dart';
import '../../../core/cache/onboarding_cache_helper.dart';

import '../../auth/view/auth_screen.dart';
import '../../customer/view/main_navigation_screen.dart';
import '../../language/view/language_screen.dart';
import '../../onboarding/view/onboarding_screen.dart';
import '../../trader/view/trader_main_layout.dart';

class SplashResolver {
  static Future<Widget> resolve() async {
    final lang = await LanguageCacheHelper().getCachedLanguageCode();
    if (lang.isEmpty) return const LanguageScreen();

    final done = await OnboardingCacheHelper().isOnboardingCompleted();
    if (!done) return const OnboardingScreen();

    final auth = AuthCacheHelper();
    final loggedIn = await auth.isLoggedIn();
    if (!loggedIn) return const AuthScreen();

    final role = await auth.getRole();
    return role == 'trader'
        ? const TraderMainLayout()
        : const CustomerMainLayout();
  }
}
