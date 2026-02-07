import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/profile/trader_profile_header.dart';
import '../widgets/profile/trader_profile_menu.dart';

class TraderProfileScreen extends StatelessWidget {
  const TraderProfileScreen({super.key});

  // Mock data - will come from backend
  String get _traderId =>
      'TRT-${DateTime.now().millisecondsSinceEpoch % 100000}';
  String get _traderName => 'محمد أحمد';
  String get _shopName => 'متجر الأثاث الفاخر';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TraderProfileHeader(
              traderName: _traderName,
              traderId: _traderId,
              shopName: _shopName,
            ),
            const SizedBox(height: 20),
            const TraderProfileMenu(),
          ],
        ),
      ),
    );
  }
}
