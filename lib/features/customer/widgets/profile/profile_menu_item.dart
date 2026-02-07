import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: r.spacing(8)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(r.spacing(10)),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: r.responsive(mobile: 22, tablet: 24, desktop: 26),
              ),
            ),
            SizedBox(width: r.spacing(14)),
            Expanded(
              child: Text(title,
                  style: AppTextStyles.bodyMedium(context)
                      .copyWith(fontWeight: FontWeight.w600)),
            ),
            Icon(
              Icons.arrow_back_ios,
              size: r.responsive(mobile: 16, tablet: 18, desktop: 20),
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
