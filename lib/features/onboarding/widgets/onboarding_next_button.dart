import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class OnboardingNextButton extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onComplete;

  const OnboardingNextButton({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isLastPage = currentPage == totalPages - 1;

    return Padding(
      padding: EdgeInsets.all(r.spacing(24)),
      child: SizedBox(
        width: double.infinity,
        height: r.spacing(56),
        child: ElevatedButton(
          onPressed: isLastPage ? onComplete : onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 5,
          ),
          child: Text(
            isLastPage ? 'get_started'.tr(context) : 'next'.tr(context),
            style: TextStyle(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
