import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

class LanguageIcon extends StatelessWidget {
  const LanguageIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Icon(
      Icons.language,
      size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
      color: Colors.white,
    );
  }
}
