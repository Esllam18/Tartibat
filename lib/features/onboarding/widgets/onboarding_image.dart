import 'package:flutter/material.dart';
import 'package:tartibat/core/utils/responsive.dart';

class OnboardingImage extends StatelessWidget {
  final Widget imageWidget;

  const OnboardingImage({
    super.key,
    required this.imageWidget,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      height: r.responsive(mobile: 300, tablet: 400, desktop: 500),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: imageWidget,
      ),
    );
  }
}
