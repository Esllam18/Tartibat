import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/models/merchant_profile_model.dart';

class MerchantProfileHeader extends StatelessWidget {
  final MerchantProfile profile;

  const MerchantProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: r.spacing(16)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF8B6F47),
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(r.spacing(24)),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: r.responsive(mobile: 80, tablet: 90, desktop: 100),
                      height:
                          r.responsive(mobile: 80, tablet: 90, desktop: 100),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.store,
                          size:
                              r.responsive(mobile: 40, tablet: 45, desktop: 50),
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    SizedBox(width: r.spacing(20)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.getStoreName(isArabic),
                            style: GoogleFonts.cairo(
                              fontSize: r.fontSize(22),
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: r.spacing(4)),
                          Text(
                            profile.ownerName,
                            style: GoogleFonts.cairo(
                              fontSize: r.fontSize(14),
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r.spacing(20)),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(r.spacing(12)),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.email_outlined,
                                    size: 14, color: Colors.white),
                                SizedBox(width: r.spacing(6)),
                                Flexible(
                                  child: Text(
                                    profile.email,
                                    style: GoogleFonts.cairo(
                                      fontSize: r.fontSize(11),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: r.spacing(12)),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(r.spacing(12)),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone_outlined,
                                    size: 14, color: Colors.white),
                                SizedBox(width: r.spacing(6)),
                                Text(
                                  profile.phone,
                                  style: GoogleFonts.cairo(
                                    fontSize: r.fontSize(11),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
