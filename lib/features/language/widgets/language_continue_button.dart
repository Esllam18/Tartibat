import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';

class LanguageContinueButton extends StatelessWidget {
  final bool enabled;
  final String label;
  final VoidCallback onPressed;

  const LanguageContinueButton({
    super.key,
    required this.enabled,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(24)),
      child: SizedBox(
        width: double.infinity,
        height: r.spacing(54),
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
            disabledBackgroundColor: Colors.white24,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: Text(label,
              style: GoogleFonts.cairo(
                  fontSize: r.fontSize(16), fontWeight: FontWeight.w800)),
        ),
      ),
    );
  }
}
