import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class SplashTextBlock extends StatelessWidget {
  const SplashTextBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (_, t, __) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, (1 - t) * 10),
          child: Column(children: [
            Text('ترتيبات',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                    fontSize: r.fontSize(34),
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
            SizedBox(height: r.spacing(4)),
            Text('Tarteebat',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: r.fontSize(18),
                    fontWeight: FontWeight.w600,
                    color: Colors.white70)),
            SizedBox(height: r.spacing(10)),
            Text('splash_tagline'.tr(context),
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                    fontSize: r.fontSize(14),
                    color: Colors.white70,
                    height: 1.3)),
          ]),
        ),
      ),
    );
  }
}
