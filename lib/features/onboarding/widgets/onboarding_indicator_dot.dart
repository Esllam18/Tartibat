import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

class OnboardingIndicatorDot extends StatelessWidget {
  final bool isActive;
  const OnboardingIndicatorDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      margin: EdgeInsets.symmetric(horizontal: r.spacing(4)),
      width: isActive ? r.spacing(28) : r.spacing(10),
      height: r.spacing(10),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(.40),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
