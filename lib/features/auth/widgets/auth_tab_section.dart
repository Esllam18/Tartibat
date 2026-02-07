import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import 'auth_tab_bar.dart';
import 'login_form.dart';
import 'register_form.dart';

class AuthTabSection extends StatefulWidget {
  const AuthTabSection({super.key});

  @override
  State<AuthTabSection> createState() => _AuthTabSectionState();
}

class _AuthTabSectionState extends State<AuthTabSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.all(r.paddingHorizontal),
      padding: EdgeInsets.all(r.spacing(24)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          AuthTabBar(controller: _tabController),
          SizedBox(height: r.spacing(24)),
          SizedBox(
            height: r.responsive(mobile: 450, tablet: 500, desktop: 550),
            child: TabBarView(
              controller: _tabController,
              children: const [
                LoginForm(),
                RegisterForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
