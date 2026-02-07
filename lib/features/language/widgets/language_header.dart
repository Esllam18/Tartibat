import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class LanguageHeader extends StatelessWidget {
  const LanguageHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Padding(
      padding: EdgeInsets.only(
          top: r.spacing(18), left: r.spacing(24), right: r.spacing(24)),
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(r.spacing(22)),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.14),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24)),
          child: Icon(Icons.translate_rounded,
              size:
                  r.responsive(mobile: 56, tablet: 72, desktop: 88).toDouble(),
              color: Colors.white),
        ),
        SizedBox(height: r.spacing(16)),
        Text('choose_language'.tr(context),
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
                fontSize: r.fontSize(28),
                fontWeight: FontWeight.w800,
                color: Colors.white)),
        SizedBox(height: r.spacing(8)),
        Text('select_preferred_language'.tr(context),
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
                fontSize: r.fontSize(14), height: 1.3, color: Colors.white70)),
      ]),
    );
  }
}
