import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/responsive_padding.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/login_form.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_footer.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ResponsiveContainer(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ResponsivePadding(
              vertical: true,
              child: Column(
                children: [
                  SizedBox(height: r.spacing(40)),
                  AuthHeader(
                    title: 'login'.tr(context),
                    subtitle: 'welcome_to'.tr(context),
                  ),
                  SizedBox(height: r.spacing(40)),
                  const LoginForm(),
                  SizedBox(height: r.spacing(24)),
                  AuthFooter(
                    question: 'dont_have_account'.tr(context),
                    actionText: 'register'.tr(context),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
