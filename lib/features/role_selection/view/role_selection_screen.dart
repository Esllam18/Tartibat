import 'package:flutter/material.dart';
import 'package:tartibat/features/merchant/view/merchant_main_layout.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/cache/auth_cache_helper.dart';
import '../../../core/utils/responsive.dart';
import '../../customer/view/main_navigation_screen.dart';
import '../widgets/role_selection_header.dart';
import '../widgets/role_selection_cards.dart';
import '../widgets/continue_button.dart';

class RoleSelectionScreen extends StatefulWidget {
  final String userName, userEmail, userPhone;

  const RoleSelectionScreen({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
  });

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;
  bool _isLoading = false;

  void _onRoleSelect(String role) => setState(() => _selectedRole = role);

  Future<void> _handleContinue() async {
    if (_selectedRole == null) return;
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 600));
    await AuthCacheHelper().saveAuthData(
      token: 'token_${DateTime.now().millisecondsSinceEpoch}',
      role: _selectedRole!,
      userName: widget.userName,
      userEmail: widget.userEmail,
      isTraderApproved: true,
    );

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => _selectedRole == 'trader'
            ? const MerchantMainLayout()
            : const CustomerMainLayout(),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: r.spacing(24)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: r.spacing(20)),
                const RoleSelectionHeader(),
                SizedBox(height: r.spacing(40)),
                RoleSelectionCards(
                  selectedRole: _selectedRole,
                  onRoleSelect: _onRoleSelect,
                ),
                SizedBox(height: r.spacing(40)),
                ContinueButton(
                  isEnabled: _selectedRole != null && !_isLoading,
                  isLoading: _isLoading,
                  onPressed: _handleContinue,
                ),
                SizedBox(height: r.spacing(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
