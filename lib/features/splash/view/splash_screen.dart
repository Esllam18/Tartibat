import 'package:flutter/material.dart';
import 'package:tartibat/features/customer/view/main_navigation_screen.dart';
import '../../../core/cache/onboarding_cache_helper.dart';
import '../../../core/cache/language_cache_helper.dart';
import '../../../core/cache/auth_cache_helper.dart';
import '../widgets/splash_background.dart';
import '../widgets/splash_content.dart';
import '../../language/view/language_screen.dart';
import '../../onboarding/view/onboarding_screen.dart';
import '../../auth/view/auth_screen.dart';
import '../../trader/view/trader_main_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final language = LanguageCacheHelper();
    final onboarding = OnboardingCacheHelper();
    final auth = AuthCacheHelper();

    final languageCode = await language.getCachedLanguageCode();
    final onboardingCompleted = await onboarding.isOnboardingCompleted();
    final isLoggedIn = await auth.isLoggedIn();

    Widget nextScreen;

    if (languageCode.isEmpty) {
      nextScreen = const LanguageScreen();
    } else if (!onboardingCompleted) {
      nextScreen = const OnboardingScreen();
    } else if (isLoggedIn) {
      nextScreen = const AuthScreen();
    } else {
      final role = await auth.getRole();
      nextScreen = role == 'trader'
          ? const TraderMainLayout()
          : const CustomerMainLayout();
    }

    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (_) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashBackground(child: SplashContent()));
  }
}
