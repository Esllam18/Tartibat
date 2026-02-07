import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class LanguageHeader extends StatelessWidget {
  const LanguageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(r.spacing(24)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.language,
            size: r.responsive(mobile: 64, tablet: 80, desktop: 96),
            color: Colors.white,
          ),
        ),
        SizedBox(height: r.spacing(24)),
        Text(
          'choose_language'.tr(context),
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(32),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: r.spacing(12)),
        Text(
          'select_preferred_language'.tr(context),
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(16),
            color: Colors.white70,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
