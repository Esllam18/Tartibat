import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../role_selection/view/role_selection_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'test');
  final _emailController = TextEditingController(text: 'test@gmail.com');
  final _passwordController = TextEditingController(text: 'password123');
  final _confirmPasswordController = TextEditingController(text: 'password123');
  final _phoneController = TextEditingController(text: '+1234567890');
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              controller: _nameController,
              label: 'full_name'.tr(context),
              icon: Icons.person_outline,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'required_field'.tr(context) : null,
            ),
            SizedBox(height: r.spacing(16)),
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
              controller: _phoneController,
              label: 'phone'.tr(context),
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'required_field'.tr(context) : null,
            ),
            SizedBox(height: r.spacing(16)),
            CustomTextField(
              controller: _passwordController,
              label: 'password'.tr(context),
              icon: Icons.lock_outline,
              isPassword: true,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'required_field'.tr(context);
                if (value!.length < 6) return 'password_too_short'.tr(context);
                return null;
              },
            ),
            SizedBox(height: r.spacing(16)),
            CustomTextField(
              controller: _confirmPasswordController,
              label: 'confirm_password'.tr(context),
              icon: Icons.lock_outline,
              isPassword: true,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'required_field'.tr(context);
                if (value != _passwordController.text) {
                  return 'passwords_not_match'.tr(context);
                }
                return null;
              },
            ),
            SizedBox(height: r.spacing(24)),
            CustomButton(
              text: 'register'.tr(context),
              isLoading: _isLoading,
              onPressed: _handleRegister,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // Navigate to Role Selection Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RoleSelectionScreen(
          userName: _nameController.text,
          userEmail: _emailController.text,
          userPhone: _phoneController.text,
        ),
      ),
    );

    setState(() => _isLoading = false);
  }
}
