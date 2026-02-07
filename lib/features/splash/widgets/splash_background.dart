import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;
  const SplashBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Stack(
          children: [
            _blob(const Alignment(-0.9, -0.7), 260, 0.10),
            _blob(const Alignment(0.9, 0.2), 220, 0.08),
            _blob(const Alignment(-0.2, 0.95), 280, 0.07),
            child,
          ],
        ),
      ),
    );
  }

  Widget _blob(Alignment a, double s, double o) {
    return Align(
      alignment: a,
      child: Container(
        width: s,
        height: s,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(o),
        ),
      ),
    );
  }
}
