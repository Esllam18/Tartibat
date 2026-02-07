import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class SplashSubtitle extends StatelessWidget {
  const SplashSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Text(
      'luxury_furniture'.tr(context),
      style: GoogleFonts.cairo(
        fontSize: r.fontSize(16),
        color: Colors.white70,
      ),
    );
  }
}
