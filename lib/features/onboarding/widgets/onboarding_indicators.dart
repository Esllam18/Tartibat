import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';
import 'onboarding_indicator_dot.dart';

class OnboardingIndicators extends StatelessWidget {
  final int count, currentIndex;
  const OnboardingIndicators(
      {super.key, required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.spacing(18)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            count, (i) => OnboardingIndicatorDot(isActive: i == currentIndex)),
      ),
    );
  }
}
