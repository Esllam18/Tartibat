import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../data/models/merchant_profile_model.dart';

class MerchantStatsSection extends StatelessWidget {
  final MerchantProfile profile;

  const MerchantStatsSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: r.spacing(16)),
      padding: EdgeInsets.all(r.spacing(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'store_performance'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(16)),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context: context,
                  r: r,
                  icon: Icons.attach_money,
                  label: 'total_earnings'.tr(context),
                  value: '\$${profile.totalEarnings.toStringAsFixed(0)}',
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade600],
                  ),
                ),
              ),
              SizedBox(width: r.spacing(12)),
              Expanded(
                child: _buildStatCard(
                  context: context,
                  r: r,
                  icon: Icons.shopping_bag,
                  label: 'products_sold'.tr(context),
                  value: profile.totalProductsSold.toString(),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade600],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: r.spacing(12)),
          _buildStatCard(
            context: context,
            r: r,
            icon: Icons.receipt_long,
            label: 'orders_handled'.tr(context),
            value: profile.totalOrdersHandled.toString(),
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.orange.shade600],
            ),
            isWide: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required Responsive r,
    required IconData icon,
    required String label,
    required String value,
    required Gradient gradient,
    bool isWide = false,
  }) {
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
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                SizedBox(width: r.spacing(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
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
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(r.spacing(10)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                SizedBox(height: r.spacing(12)),
                Text(
                  value,
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(24),
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: r.spacing(4)),
                Text(
                  label,
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(12),
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
