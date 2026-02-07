import 'package:flutter/material.dart';
import '../logic/splash_navigator.dart';
import '../widgets/splash_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashNavigator.go(context);
  }

  @override
  Widget build(BuildContext context) => const Scaffold(body: SplashView());
}
