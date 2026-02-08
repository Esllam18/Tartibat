import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../data/onboarding_data.dart';
import 'onboarding_image.dart';
import 'onboarding_text.dart';
import 'onboarding_indicators.dart';
import 'onboarding_next_button.dart';
import 'onboarding_skip_button.dart';

class OnboardingPageView extends StatelessWidget {
  final PageController controller;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onComplete;

  const OnboardingPageView({
    super.key,
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: SafeArea(
        child: Column(
          children: [
            OnboardingSkipButton(onSkip: onComplete),
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: onPageChanged,
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  final data = onboardingPages[index];
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: r.paddingHorizontal),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OnboardingImage(imageUrl: data.imageUrl),
                        SizedBox(height: r.spacing(40)),
                        OnboardingText(
                          titleKey: data.titleKey,
                          descriptionKey: data.descriptionKey,
                        ),
                      ],
                    ),
                  );
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
              onNext: () => controller.nextPage(
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
