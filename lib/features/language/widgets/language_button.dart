import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/utils/responsive.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
    required this.flag,
    required this.language,
    required this.languageCode,
    required this.onTap,
  });

  final String flag;
  final String language;
  final String languageCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: r.spacing(20),
          horizontal: r.spacing(16),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              flag,
              style: TextStyle(fontSize: r.fontSize(32)),
            ),
            SizedBox(width: r.spacing(16)),
            Text(
              language,
              style: TextStyle(
                fontSize: r.fontSize(22),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
