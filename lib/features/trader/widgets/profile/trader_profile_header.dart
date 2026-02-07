import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'trader_id_card.dart';

class TraderProfileHeader extends StatelessWidget {
  final String traderName;
  final String traderId;
  final String shopName;

  const TraderProfileHeader({
    super.key,
    required this.traderName,
    required this.traderId,
    required this.shopName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildAvatar(),
            const SizedBox(height: 16),
            _buildTraderInfo(context),
            const SizedBox(height: 20),
            TraderIdCard(traderId: traderId),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.store,
        size: 50,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildTraderInfo(BuildContext context) {
    return Column(
      children: [
        Text(
          traderName,
          style: AppTextStyles.h2(context).copyWith(color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          shopName,
          style: AppTextStyles.bodyMedium(context).copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
