import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/auth/admin_login_form.dart';
import 'admin_main_layout.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 40),
                Text(
                  'admin_panel'.tr(context),
                  style: AppTextStyles.h1(context),
                ),
                const SizedBox(height: 8),
                Text(
                  'admin_login_subtitle'.tr(context),
                  style: AppTextStyles.bodyMedium(context),
                ),
                const SizedBox(height: 40),
                AdminLoginForm(
                  onLogin: () => _navigateToAdmin(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child:
          const Icon(Icons.admin_panel_settings, size: 60, color: Colors.white),
    );
  }

  void _navigateToAdmin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AdminMainLayout()),
    );
  }
}
