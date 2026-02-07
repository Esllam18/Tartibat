import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

class SplashLogoBadge extends StatelessWidget {
  const SplashLogoBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final double s =
        r.responsive(mobile: 112, tablet: 136, desktop: 156).toDouble();

    return Container(
      width: s,
      height: s,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(.22),
            Colors.white.withOpacity(.10)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(.25)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.20),
              blurRadius: 24,
              offset: const Offset(0, 14))
        ],
      ),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/logo.png',
        width: s * .54,
        height: s * .54,
        errorBuilder: (_, __, ___) =>
            Icon(Icons.chair_rounded, size: s * .54, color: Colors.white),
      ),
    );
  }
}
