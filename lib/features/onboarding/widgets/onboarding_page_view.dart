import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../data/onboarding_data.dart';
import 'onboarding_indicators.dart';
import 'onboarding_next_button.dart';
import 'onboarding_page.dart';
import 'onboarding_skip_button.dart';

class OnboardingPageView extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onComplete;
  const OnboardingPageView(
      {super.key,
      required this.pageController,
      required this.currentPage,
      required this.onPageChanged,
      required this.onComplete});

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Column(children: [
            OnboardingSkipButton(onSkip: onComplete),
            Expanded(
                child: PageView.builder(
              controller: pageController,
              onPageChanged: onPageChanged,
              itemCount: onboardingPages.length,
              itemBuilder: (_, i) => OnboardingPage(data: onboardingPages[i]),
            )),
            OnboardingIndicators(
                count: onboardingPages.length, currentIndex: currentPage),
            OnboardingNextButton(
              currentPage: currentPage,
              totalPages: onboardingPages.length,
              onNext: () => pageController.nextPage(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic),
              onComplete: onComplete,
            ),
          ]),
        ),
      );
}
