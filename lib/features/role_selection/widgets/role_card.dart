import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class RoleCard extends StatelessWidget {
  final String role, titleKey, descriptionKey;
  final IconData icon;
  final Gradient gradient;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.role,
    required this.icon,
    required this.titleKey,
    required this.descriptionKey,
    required this.gradient,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(r.spacing(22)),
        decoration: BoxDecoration(
          gradient: isSelected ? gradient : null,
          color: isSelected ? null : Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.25),
            width: isSelected ? 3 : 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.35),
                    blurRadius: 28,
                    spreadRadius: 2,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(r.spacing(16)),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(isSelected ? 0.25 : 0.08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                size: r.responsive(mobile: 38, tablet: 44, desktop: 50),
                color: Colors.white,
              ),
            ),
            SizedBox(width: r.spacing(18)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleKey.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(21),
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: r.spacing(6)),
                  Text(
                    descriptionKey.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(14),
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) ...[
              SizedBox(width: r.spacing(12)),
              Container(
                padding: EdgeInsets.all(r.spacing(7)),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: AppColors.primary,
                  size: r.responsive(mobile: 20, tablet: 24, desktop: 26),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
