import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class LanguageBackground extends StatelessWidget {
  final Widget child;
  const LanguageBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: child,
      ),
    );
  }
}
