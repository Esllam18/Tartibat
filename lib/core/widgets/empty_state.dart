import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(r.spacing(32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(r.spacing(32)),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
            SizedBox(height: r.spacing(24)),
            Text(title, style: AppTextStyles.h3(context)),
            SizedBox(height: r.spacing(8)),
            Text(
              message,
              style: AppTextStyles.bodyMedium(context),
              textAlign: TextAlign.center,
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              SizedBox(height: r.spacing(24)),
              ElevatedButton(
                onPressed: onButtonPressed,
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
