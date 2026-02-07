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
    final maxW =
        r.responsive(mobile: 520, tablet: 720, desktop: 860).toDouble();

    final content = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxW),
      child: Padding(
        padding: EdgeInsets.all(r.spacing(24)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const RepaintBoundary(child: SplashLogoBadge()),
          SizedBox(height: r.spacing(18)),
          const RepaintBoundary(child: SplashTextBlock()),
          SizedBox(height: r.spacing(14)),
          const SplashAccent(),
          SizedBox(height: r.spacing(18)),
          const SplashLoader(),
        ]),
      ),
    );

    return SplashBackground(
      child: SafeArea(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeOutCubic,
          child: Center(child: content),
          builder: (_, t, child) => Opacity(
            opacity: t,
            child: Transform.translate(
                offset: Offset(0, (1 - t) * 14), child: child),
          ),
        ),
      ),
    );
  }
}
