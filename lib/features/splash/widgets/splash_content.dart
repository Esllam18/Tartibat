import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';
import 'splash_logo.dart';
import 'splash_app_name.dart';
import 'splash_subtitle.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SplashLogo(),
          SizedBox(height: r.spacing(20)),
          const SplashAppName(),
          SizedBox(height: r.spacing(10)),
          const SplashSubtitle(),
        ],
      ),
    );
  }
}
