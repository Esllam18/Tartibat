import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class OnboardingText extends StatelessWidget {
  final String titleKey;
  final String descriptionKey;

  const OnboardingText({
    super.key,
    required this.titleKey,
    required this.descriptionKey,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(16)),
      child: Column(
        children: [
          Text(
            titleKey.tr(context),
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(28),
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.3,
            ),
          ),
          SizedBox(height: r.spacing(16)),
          Text(
            descriptionKey.tr(context),
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(16),
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.85),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
