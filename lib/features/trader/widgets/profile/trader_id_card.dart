import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/localization/app_localizations.dart';

class TraderIdCard extends StatelessWidget {
  final String traderId;

  const TraderIdCard({super.key, required this.traderId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildIdIcon(),
          const SizedBox(width: 16),
          Expanded(child: _buildIdInfo(context)),
          _buildCopyButton(context),
        ],
      ),
    );
  }

  Widget _buildIdIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.badge, color: Colors.white, size: 28),
    );
  }

  Widget _buildIdInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'trader_id'.tr(context),
          style: AppTextStyles.bodySmall(context).copyWith(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          traderId,
          style: AppTextStyles.h3(context).copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildCopyButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.copy, color: Colors.white, size: 20),
      onPressed: () => _copyToClipboard(context),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: traderId));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('id_copied'.tr(context)),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.success,
      ),
    );
  }
}
