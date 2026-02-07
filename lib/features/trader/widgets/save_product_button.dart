import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class SaveProductButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final bool isEdit;
  const SaveProductButton(
      {super.key,
      required this.isLoading,
      required this.onPressed,
      this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusLarge))),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                    strokeWidth: 2.5, color: Colors.white))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isEdit ? Icons.check_circle : Icons.add_circle,
                      color: Colors.white, size: 22),
                  const SizedBox(width: 10),
                  Text(isEdit ? 'save_changes'.tr(context) : 'save'.tr(context),
                      style: AppTextStyles.buttonStatic.copyWith(fontSize: 16)),
                ],
              ),
      ),
    );
  }
}
