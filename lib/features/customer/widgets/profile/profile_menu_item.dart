import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: r.spacing(20),
        vertical: r.spacing(4),
      ),
      leading: Icon(
        icon,
        color: iconColor ?? AppColors.primary,
        size: 24,
      ),
      title: Text(
        title,
        style: GoogleFonts.cairo(
          fontSize: r.fontSize(15),
          fontWeight: FontWeight.w700,
          color: textColor ?? AppColors.textPrimary,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey.shade400,
      ),
    );
  }
}
