import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_tab_bar.dart';
import '../widgets/login_form.dart';
import '../widgets/register_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C5F6F), // Darker teal
              AppColors.background,
            ],
            stops: [0.0, 0.5],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: r.paddingHorizontal,
              vertical: r.spacing(24),
            ),
            child: Column(
              children: [
                SizedBox(height: r.spacing(20)),
                const AuthHeader(),
                SizedBox(height: r.spacing(40)),
                Container(
                  padding: EdgeInsets.all(r.spacing(24)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AuthTabBar(controller: _tabController),
                      SizedBox(height: r.spacing(28)),
                      SizedBox(
                        height: r.responsive(
                          mobile: 400,
                          tablet: 450,
                          desktop: 500,
                        ),
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
                ),
                SizedBox(height: r.spacing(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
