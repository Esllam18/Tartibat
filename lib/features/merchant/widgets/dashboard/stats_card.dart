import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/responsive.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final bool isWide;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(16)),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isWide
          ? Row(
              children: [
                Container(
                  padding: EdgeInsets.all(r.spacing(12)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 32),
                ),
                SizedBox(width: r.spacing(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(13),
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: r.spacing(4)),
                      Text(
                        value,
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(24),
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(12),
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(13),
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(r.spacing(6)),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: Colors.white, size: 20),
                    ),
                  ],
                ),
                SizedBox(height: r.spacing(12)),
                Text(
                  value,
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(28),
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: r.spacing(4)),
                Text(
                  subtitle,
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(12),
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
    );
  }
}
