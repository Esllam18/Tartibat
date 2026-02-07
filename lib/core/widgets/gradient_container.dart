import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const GradientContainer({
    super.key,
    required this.child,
    this.height,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: child,
    );
  }
}
