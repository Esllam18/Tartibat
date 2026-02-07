import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/responsive.dart';

class SplashAppName extends StatelessWidget {
  const SplashAppName({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Text(
      'ترتيبات',
      style: GoogleFonts.cairo(
        fontSize: r.fontSize(36),
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
