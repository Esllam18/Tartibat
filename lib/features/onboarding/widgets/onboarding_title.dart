import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class OnboardingTitle extends StatelessWidget {
  final String titleKey;
  const OnboardingTitle({super.key, required this.titleKey});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Text(
      titleKey.tr(context),
      textAlign: TextAlign.center,
      style: GoogleFonts.cairo(
          fontSize: r.fontSize(26),
          fontWeight: FontWeight.w800,
          color: Colors.white),
    );
  }
}
