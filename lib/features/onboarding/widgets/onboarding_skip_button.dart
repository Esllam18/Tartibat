import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class OnboardingSkipButton extends StatelessWidget {
  final VoidCallback onSkip;

  const OnboardingSkipButton({
    super.key,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.all(r.spacing(16)),
        child: TextButton(
          onPressed: onSkip,
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
