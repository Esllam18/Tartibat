import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashTagline extends StatelessWidget {
  final AnimationController controller;

  const SplashTagline({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    return FadeTransition(
      opacity: fadeAnim,
      child: Text(
        'Your Home, Your Style',
        textAlign: TextAlign.center,
        style: GoogleFonts.cairo(
          fontSize: 14,
          color: const Color(0xFF8B4513).withOpacity(0.6),
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
