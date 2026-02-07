import 'package:flutter/material.dart';
import 'package:tartibat/features/auth/view/auth_screen.dart';
import '../../../core/cache/onboarding_cache_helper.dart';
import '../widgets/onboarding_page_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(int p) => setState(() => _page = p);

  Future<void> _finish() async {
    await OnboardingCacheHelper().setOnboardingCompleted();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const AuthScreen()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: OnboardingPageView(
          pageController: _controller,
          currentPage: _page,
          onPageChanged: _onChanged,
          onComplete: _finish,
        ),
      );
}
