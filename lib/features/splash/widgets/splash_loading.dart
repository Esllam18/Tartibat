import 'package:flutter/material.dart';

class SplashLoading extends StatelessWidget {
  final AnimationController shimmerController;

  const SplashLoading({super.key, required this.shimmerController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              // ignore: deprecated_member_use
              const Color(0xFFD2B48C).withOpacity(0.3),
            ),
          ),
          AnimatedBuilder(
            animation: shimmerController,
            builder: (context, child) {
              return CircularProgressIndicator(
                value: shimmerController.value,
                strokeWidth: 3,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF8B4513),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
