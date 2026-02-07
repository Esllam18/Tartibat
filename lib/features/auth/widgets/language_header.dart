import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageHeader extends StatelessWidget {
  final AnimationController controller;

  const LanguageHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero)
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
          ),
        ),
        child: Column(
          children: [
            // Premium icon container
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Color(0xFFFAF9F6)],
                ),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: const Color(0xFFD2B48C).withOpacity(0.25),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 20,
                    offset: const Offset(-8, -8),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.language_rounded,
                    size: 56,
                    color: Color(0xFF8B4513),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD2B48C),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.translate_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),

            // Title with gradient
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF2C2416), Color(0xFF8B4513)],
              ).createShader(bounds),
              child: Text(
                'Welcome to Tartibat',
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'مرحباً بك في ترتيبات',
              style: GoogleFonts.cairo(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                // ignore: deprecated_member_use
                color: const Color(0xFF8B4513).withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: const Color(0xFFD2B48C).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  // ignore: deprecated_member_use
                  color: const Color(0xFFD2B48C).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                'Please select your preferred language',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF8B4513),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
