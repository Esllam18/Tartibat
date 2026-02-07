import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';
import '../data/onboarding_data.dart';
import 'onboarding_image.dart';
import 'onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;

  const OnboardingPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.paddingHorizontal),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OnboardingImage(imageWidget: data.image),
          SizedBox(height: r.spacing(40)),
          OnboardingContent(data: data),
        ],
      ),
    );
  }
}
