import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/locale_cubit.dart';

class LanguageSelectionDialog extends StatelessWidget {
  const LanguageSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: EdgeInsets.all(r.spacing(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'select_language'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(22),
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: r.spacing(8)),
            Text(
              'choose_your_preferred_language'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(13),
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: r.spacing(24)),
            BlocBuilder<LocaleCubit, ChangeLocaleState>(
              builder: (context, state) {
                final isArabic = state.locale.languageCode == 'ar';

                return Column(
                  children: [
                    _buildLanguageOption(
                      context: context,
                      r: r,
                      language: 'العربية',
                      code: 'ar',
                      isSelected: isArabic,
                      onTap: () {
                        context.read<LocaleCubit>().changeLanguage('ar');
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: r.spacing(12)),
                    _buildLanguageOption(
                      context: context,
                      r: r,
                      language: 'English',
                      code: 'en',
                      isSelected: !isArabic,
                      onTap: () {
                        context.read<LocaleCubit>().changeLanguage('en');
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required Responsive r,
    required String language,
    required String code,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: r.spacing(20),
          vertical: r.spacing(16),
        ),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.primaryGradient : null,
          color: isSelected ? null : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 14, color: AppColors.primary)
                  : null,
            ),
            SizedBox(width: r.spacing(16)),
            Expanded(
              child: Text(
                language,
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(18),
                  fontWeight: FontWeight.w800,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: r.spacing(10),
                vertical: r.spacing(4),
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                code.toUpperCase(),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(12),
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
