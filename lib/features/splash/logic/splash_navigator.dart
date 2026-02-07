import 'package:flutter/material.dart';
import 'splash_resolver.dart';

class SplashNavigator {
  static Future<void> go(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    if (!context.mounted) return;

    final next = await SplashResolver.resolve();
    if (!context.mounted) return;

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => next));
  }
}
