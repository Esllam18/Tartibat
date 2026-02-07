import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Icon(
      Icons.chair,
      size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
      color: Colors.white,
    );
  }
}
