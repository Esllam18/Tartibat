import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../data/onboarding_data.dart';
import 'onboarding_page.dart';
import 'onboarding_indicators.dart';
import 'onboarding_next_button.dart';
import 'onboarding_skip_button.dart';

class OnboardingPageView extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final Function(int) onPageChanged;
  final VoidCallback onComplete;

  const OnboardingPageView({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.onPageChanged,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: SafeArea(
        child: Column(
          children: [
            OnboardingSkipButton(onSkip: onComplete),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: onPageChanged,
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(data: onboardingPages[index]);
                },
              ),
            ),
            OnboardingIndicators(
              count: onboardingPages.length,
              currentIndex: currentPage,
            ),
            OnboardingNextButton(
              currentPage: currentPage,
              totalPages: onboardingPages.length,
              onNext: () => pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              onComplete: onComplete,
            ),
          ],
        ),
      ),
    );
  }
}
