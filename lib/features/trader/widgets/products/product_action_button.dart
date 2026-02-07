import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProductActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const ProductActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 18,
          color: color ?? AppColors.primary,
        ),
      ),
    );
  }
}
