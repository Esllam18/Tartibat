import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

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
      padding: EdgeInsets.fromLTRB(
        r.spacing(24),
        r.spacing(8),
        r.spacing(24),
        r.spacing(28),
      ),
      child: SizedBox(
        width: double.infinity,
        height: r.spacing(58),
        child: ElevatedButton(
          onPressed: isLastPage ? onComplete : onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Text(
            isLastPage ? 'get_started'.tr(context) : 'next'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
