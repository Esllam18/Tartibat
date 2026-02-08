import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class OnboardingSkipButton extends StatelessWidget {
  final VoidCallback onSkip;

  const OnboardingSkipButton({super.key, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Padding(
        padding: EdgeInsets.all(r.spacing(12)),
        child: TextButton(
          onPressed: onSkip,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: r.spacing(16),
              vertical: r.spacing(8),
            ),
          ),
          child: Text(
            'skip'.tr(context),
            style: TextStyle(
              color: Colors.white,
              fontSize: r.fontSize(16),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
