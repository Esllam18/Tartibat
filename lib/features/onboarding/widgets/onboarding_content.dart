import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';
import '../data/onboarding_data.dart';
import 'onboarding_title.dart';
import 'onboarding_description.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingPageData data;

  const OnboardingContent({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OnboardingTitle(titleKey: data.titleKey),
        SizedBox(height: r.spacing(16)),
        OnboardingDescription(descriptionKey: data.descriptionKey),
      ],
    );
  }
}
