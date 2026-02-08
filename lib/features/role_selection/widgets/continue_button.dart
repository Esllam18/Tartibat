import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class ContinueButton extends StatelessWidget {
  final bool isEnabled, isLoading;
  final VoidCallback onPressed;

  const ContinueButton({
    super.key,
    required this.isEnabled,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(24)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: double.infinity,
        height: r.spacing(60),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(18),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isEnabled ? onPressed : null,
            borderRadius: BorderRadius.circular(18),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 26,
                      height: 26,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: AppColors.primary,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: isEnabled
                              ? AppColors.primary
                              : AppColors.primary.withOpacity(0.5),
                          size:
                              r.responsive(mobile: 24, tablet: 26, desktop: 28),
                        ),
                        SizedBox(width: r.spacing(12)),
                        Text(
                          'continue'.tr(context),
                          style: GoogleFonts.cairo(
                            fontSize: r.fontSize(19),
                            fontWeight: FontWeight.w800,
                            color: isEnabled
                                ? AppColors.primary
                                : AppColors.primary.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
