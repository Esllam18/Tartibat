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
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.all(r.spacing(12)),
        child: TextButton(
          onPressed: onSkip,
          child: Text('skip'.tr(context),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: r.fontSize(15),
                  fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
