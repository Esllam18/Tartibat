import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'good_morning'.tr(context);
    if (hour < 17) return 'good_afternoon'.tr(context);
    return 'good_evening'.tr(context);
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.fromLTRB(
        r.spacing(20),
        r.spacing(60),
        r.spacing(20),
        r.spacing(32),
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-1.0, -1.0),
          end: Alignment(1.0, 1.0),
          colors: [
            Color(0xFF1B7F79),
            Color(0xFF2D9B94),
            Color(0xFF4DB5AE),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(r.spacing(36)),
          bottomRight: Radius.circular(r.spacing(36)),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B7F79).withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.spacing(12),
                    vertical: r.spacing(6),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getGreeting(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(13),
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ),
                SizedBox(height: r.spacing(12)),
                Text(
                  'explore_furniture'.tr(context),
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(28),
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.1,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: r.spacing(6)),
                Text(
                  'find_perfect_pieces'.tr(context),
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(14),
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: r.spacing(12)),
          Container(
            padding: EdgeInsets.all(r.spacing(14)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
              size: r.responsive(mobile: 26, tablet: 28, desktop: 30),
            ),
          ),
        ],
      ),
    );
  }
}
