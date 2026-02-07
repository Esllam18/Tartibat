import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class OnboardingTitle extends StatelessWidget {
  final String titleKey;

  const OnboardingTitle({
    super.key,
    required this.titleKey,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Text(
      titleKey.tr(context),
      style: GoogleFonts.cairo(
        fontSize: r.fontSize(28),
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
