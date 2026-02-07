import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class OnboardingDescription extends StatelessWidget {
  final String descriptionKey;

  const OnboardingDescription({
    super.key,
    required this.descriptionKey,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(20)),
      child: Text(
        descriptionKey.tr(context),
        style: GoogleFonts.cairo(
          fontSize: r.fontSize(16),
          color: Colors.white70,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
