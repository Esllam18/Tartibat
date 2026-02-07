import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class RoleSelectionHeader extends StatelessWidget {
  const RoleSelectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            builder: (_, value, __) => Transform.scale(
              scale: value,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5)
                  ],
                ),
                child: const Icon(Icons.supervised_user_circle_rounded,
                    size: 70, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('choose_account_type'.tr(context),
              style: AppTextStyles.h1Static
                  .copyWith(color: Colors.white, fontSize: 28),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('select_role_subtitle'.tr(context),
              style: AppTextStyles.bodyMediumStatic
                  .copyWith(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
