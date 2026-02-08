import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class RoleSelectionHeader extends StatelessWidget {
  const RoleSelectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(24)),
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 900),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  padding: EdgeInsets.all(r.spacing(22)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.35),
                        blurRadius: 35,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.supervised_user_circle_rounded,
                    size: r.responsive(mobile: 65, tablet: 80, desktop: 90),
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: r.spacing(26)),
          Text(
            'choose_account_type'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(30),
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spacing(14)),
          Text(
            'select_role_subtitle'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(16),
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.85),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
