import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class ContinueButton extends StatelessWidget {
  final bool isEnabled, isLoading;
  final VoidCallback onPressed;
  const ContinueButton(
      {super.key,
      required this.isEnabled,
      required this.isLoading,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: isEnabled ? Colors.white : Colors.white24,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10))
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isEnabled ? onPressed : null,
            borderRadius: BorderRadius.circular(16),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                          strokeWidth: 2.5, color: AppColors.primary))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_forward_rounded,
                            color: AppColors.primary, size: 22),
                        const SizedBox(width: 10),
                        Text('continue'.tr(context),
                            style: AppTextStyles.h4Static.copyWith(
                                color: AppColors.primary, fontSize: 18)),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
