import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';

class ProductSubmissionDialog extends StatelessWidget {
  const ProductSubmissionDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ProductSubmissionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.statusPending.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.pending_actions,
              size: 60,
              color: AppColors.statusPending,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'product_submitted'.tr(context),
            style: AppTextStyles.h3(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'product_pending_review'.tr(context),
            style: AppTextStyles.bodyMedium(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Back to products screen
              },
              child: Text('ok'.tr(context)),
            ),
          ),
        ],
      ),
    );
  }
}
