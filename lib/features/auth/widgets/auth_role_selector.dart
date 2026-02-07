import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class AuthRoleSelector extends StatelessWidget {
  final String selectedRole;
  final Function(String) onRoleChanged;

  const AuthRoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.all(r.spacing(24)),
      child: Column(
        children: [
          SizedBox(height: r.spacing(20)),
          Text(
            'welcome_to_app'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(32),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: r.spacing(8)),
          Text(
            'select_account_type'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(16),
              color: Colors.white70,
            ),
          ),
          SizedBox(height: r.spacing(32)),
          Row(
            children: [
              Expanded(
                child: _buildRoleCard(
                  context: context,
                  role: 'customer',
                  icon: Icons.shopping_bag_outlined,
                  title: 'customer'.tr(context),
                  subtitle: 'buy_furniture'.tr(context),
                  r: r,
                ),
              ),
              SizedBox(width: r.spacing(16)),
              Expanded(
                child: _buildRoleCard(
                  context: context,
                  role: 'trader',
                  icon: Icons.store_outlined,
                  title: 'trader'.tr(context),
                  subtitle: 'sell_furniture'.tr(context),
                  r: r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String role,
    required IconData icon,
    required String title,
    required String subtitle,
    required Responsive r,
  }) {
    final isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () => onRoleChanged(role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(r.spacing(20)),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white24,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(r.spacing(16)),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.white24,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: r.spacing(40),
                color: isSelected ? AppColors.primary : Colors.white,
              ),
            ),
            SizedBox(height: r.spacing(12)),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(18),
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.primary : Colors.white,
              ),
            ),
            SizedBox(height: r.spacing(4)),
            Text(
              subtitle,
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(12),
                color: isSelected ? AppColors.textSecondary : Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
