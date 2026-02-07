import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/cache/auth_cache_helper.dart';
import '../../customer/view/main_navigation_screen.dart';
import '../../trader/view/trader_main_layout.dart';
import '../widgets/role_selection_header.dart';
import '../widgets/role_selection_cards.dart';
import '../widgets/continue_button.dart';

class RoleSelectionScreen extends StatefulWidget {
  final String userName, userEmail, userPhone;
  const RoleSelectionScreen(
      {super.key,
      required this.userName,
      required this.userEmail,
      required this.userPhone});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              const RoleSelectionHeader(),
              const Spacer(flex: 2),
              RoleSelectionCards(
                selectedRole: _selectedRole,
                onRoleSelect: (role) => setState(() => _selectedRole = role),
              ),
              const Spacer(flex: 2),
              ContinueButton(
                isEnabled: _selectedRole != null && !_isLoading,
                isLoading: _isLoading,
                onPressed: _handleContinue,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleContinue() async {
    if (_selectedRole == null) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    await AuthCacheHelper().saveAuthData(
        token: 'token_${DateTime.now().millisecondsSinceEpoch}',
        role: _selectedRole!,
        userName: widget.userName,
        userEmail: widget.userEmail,
        isTraderApproved: true);
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => _selectedRole == 'trader'
                ? const TraderMainLayout()
                : const CustomerMainLayout()),
        (_) => false);
  }
}
