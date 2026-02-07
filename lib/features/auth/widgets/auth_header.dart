import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Column(
      children: [
        Icon(
          Icons.chair,
          size: r.responsive(mobile: 60, tablet: 80, desktop: 100),
          color: AppColors.primary,
        ),
        SizedBox(height: r.spacing(16)),
        Text(title, style: AppTextStyles.h1(context)),
        SizedBox(height: r.spacing(8)),
        Text(
          subtitle,
          style: AppTextStyles.bodyMedium(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
