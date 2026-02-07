import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/responsive.dart';

class SplashAppName extends StatelessWidget {
  const SplashAppName({super.key});

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
          offset: Offset(0, (1 - t) * 12),
          child: Column(
            children: [
              Text('ترتيبات',
                  style: GoogleFonts.cairo(
                      fontSize: r.fontSize(34),
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
              SizedBox(height: r.spacing(4)),
              Text('Tarteebat',
                  style: GoogleFonts.poppins(
                      fontSize: r.fontSize(18),
                      fontWeight: FontWeight.w600,
                      color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
