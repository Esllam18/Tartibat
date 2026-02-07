import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/features/customer/view/main_navigation_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/cache/auth_cache_helper.dart';
import '../../trader/view/trader_pending_approval_screen.dart';
import 'auth_text_field.dart';
import 'auth_button.dart';

class AuthFormSection extends StatefulWidget {
  final String selectedRole;
  final bool isLogin;
  final VoidCallback onToggleMode;

  const AuthFormSection({
    super.key,
    required this.selectedRole,
    required this.isLogin,
    required this.onToggleMode,
  });

  @override
  State<AuthFormSection> createState() => _AuthFormSectionState();
}

class _AuthFormSectionState extends State<AuthFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.all(r.spacing(24)),
      padding: EdgeInsets.all(r.spacing(24)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isLogin ? 'login'.tr(context) : 'register'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(28),
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: r.spacing(8)),
            Text(
              widget.isLogin
                  ? 'login_subtitle'.tr(context)
                  : 'register_subtitle'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(14),
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: r.spacing(24)),
            if (!widget.isLogin) ...[
              AuthTextField(
                controller: _nameController,
                label: 'full_name'.tr(context),
                icon: Icons.person_outline,
                validator: (value) => value?.isEmpty ?? true
                    ? 'required_field'.tr(context)
                    : null,
              ),
              SizedBox(height: r.spacing(16)),
            ],
            AuthTextField(
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
            AuthTextField(
              controller: _passwordController,
              label: 'password'.tr(context),
              icon: Icons.lock_outline,
              isPassword: true,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'required_field'.tr(context);
                if (!widget.isLogin && value!.length < 6) {
                  return 'password_too_short'.tr(context);
                }
                return null;
              },
            ),
            if (!widget.isLogin) ...[
              SizedBox(height: r.spacing(16)),
              AuthTextField(
                controller: _phoneController,
                label: 'phone'.tr(context),
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) => value?.isEmpty ?? true
                    ? 'required_field'.tr(context)
                    : null,
              ),
              SizedBox(height: r.spacing(16)),
              AuthTextField(
                controller: _addressController,
                label: 'address'.tr(context),
                icon: Icons.location_on_outlined,
                maxLines: 2,
                validator: (value) => value?.isEmpty ?? true
                    ? 'required_field'.tr(context)
                    : null,
              ),
            ],
            if (widget.isLogin) ...[
              SizedBox(height: r.spacing(8)),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'forgot_password'.tr(context),
                    style: GoogleFonts.cairo(
                      color: AppColors.primary,
                      fontSize: r.fontSize(14),
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: r.spacing(24)),
            AuthButton(
              text:
                  widget.isLogin ? 'login'.tr(context) : 'register'.tr(context),
              isLoading: _isLoading,
              onPressed: _handleAuth,
            ),
            SizedBox(height: r.spacing(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.isLogin
                      ? 'no_account'.tr(context)
                      : 'have_account'.tr(context),
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(14),
                    color: AppColors.textSecondary,
                  ),
                ),
                TextButton(
                  onPressed: widget.onToggleMode,
                  child: Text(
                    widget.isLogin
                        ? 'register'.tr(context)
                        : 'login'.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(14),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleAuth() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    final authHelper = AuthCacheHelper();
    await authHelper.saveAuthData(
      token: 'dummy_token_${DateTime.now().millisecondsSinceEpoch}',
      role: widget.selectedRole,
      userName: widget.isLogin ? 'User' : _nameController.text,
      userEmail: _emailController.text,
      isTraderApproved: false, // Traders need admin approval
    );

    if (!mounted) return;

    final nextScreen = widget.selectedRole == 'customer'
        ? const CustomerMainLayout()
        : const TraderPendingApprovalScreen();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => nextScreen),
      (route) => false,
    );
  }
}
