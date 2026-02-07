import 'package:flutter/material.dart';
import 'package:tartibat/features/splash/widgets/splash_loading.dart';
import 'package:tartibat/features/splash/widgets/splash_logo.dart';
import 'package:tartibat/features/splash/widgets/splash_texts.dart';
import '../../../core/utils/responsive.dart';
import 'splash_background.dart';
import 'splash_accent.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return SplashBackground(
      child: SafeArea(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeOutCubic,
          builder: (_, t, child) => Opacity(
            opacity: t,
            child: Transform.translate(
                offset: Offset(0, (1 - t) * 14), child: child),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(r.spacing(24)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SplashLogoBadge(),
                  SizedBox(height: r.spacing(18)),
                  const SplashTextBlock(),
                  SizedBox(height: r.spacing(14)),
                  const SplashAccent(),
                  SizedBox(height: r.spacing(18)),
                  const SplashLoader(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
