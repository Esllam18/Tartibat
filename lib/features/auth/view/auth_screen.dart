import 'package:flutter/material.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/auth_tab_section.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AuthAppBar(),
              AuthTabSection(),
            ],
          ),
        ),
      ),
    );
  }
}
