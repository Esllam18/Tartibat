import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class SplashTextBlock extends StatelessWidget {
  const SplashTextBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Column(
      children: [
        Text(
          'app_name'.tr(context),
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(36),
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.0,
          ),
        ),
        SizedBox(height: r.spacing(8)),
        Text(
          'splash_tagline'.tr(context),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(14),
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(.88),
            height: 1.35,
          ),
        ),
      ],
    );
  }
}
