import 'package:flutter/material.dart';
import 'package:tartibat/features/customer/view/main_navigation_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/cache/auth_cache_helper.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../trader/view/trader_main_layout.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _emailController,
            label: 'email'.tr(context),
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'required_field'.tr(context);
              if (!value!.contains('@')) return 'invalid_email'.tr(context);
              return null;
            },
          ),
          SizedBox(height: r.spacing(16)),
          CustomTextField(
            controller: _passwordController,
            label: 'password'.tr(context),
            icon: Icons.lock_outline,
            isPassword: true,
            validator: (value) =>
                value?.isEmpty ?? true ? 'required_field'.tr(context) : null,
          ),
          SizedBox(height: r.spacing(8)),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'forgot_password'.tr(context),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: r.fontSize(14),
                ),
              ),
            ),
          ),
          SizedBox(height: r.spacing(24)),
          CustomButton(
            text: 'login'.tr(context),
            isLoading: _isLoading,
            onPressed: _handleLogin,
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    // Simulate: Get user data from backend (including role)
    // For demo: if email contains 'trader' → trader, else customer
    final role =
        _emailController.text.contains('trader') ? 'trader' : 'customer';

    final authHelper = AuthCacheHelper();
    await authHelper.saveAuthData(
      token: 'token_${DateTime.now().millisecondsSinceEpoch}',
      role: role,
      userName: 'User',
      userEmail: _emailController.text,
      isTraderApproved: true, // Already logged in users are approved
    );

    if (!mounted) return;

    final nextScreen = role == 'trader'
        ? const TraderMainLayout()
        : const CustomerMainLayout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => nextScreen),
      (route) => false,
    );
  }
}
