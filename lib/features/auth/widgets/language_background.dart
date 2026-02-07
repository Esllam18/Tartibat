import 'package:flutter/material.dart';
import 'dart:math' as math;

class LanguageBackground extends StatelessWidget {
  const LanguageBackground({
    super.key,
    required this.floatController,
    required this.child,
  });

  final Widget child;
  final AnimationController floatController;

  IconData _getIcon(int index) {
    final icons = [
      Icons.chair_outlined,
      Icons.bed_outlined,
      Icons.table_restaurant_outlined,
      Icons.weekend_outlined,
    ];
    return icons[index % icons.length];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFBF5),
            Color(0xFFFAF3E8),
            Color(0xFFF5EDE0),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated floating furniture icons
          ...List.generate(4, (index) {
            return AnimatedBuilder(
              animation: floatController,
              builder: (context, child) {
                final offset = math.sin(
                      (floatController.value * 2 * math.pi) +
                          (index * math.pi / 2),
                    ) *
                    15;

                return Positioned(
                  top: 80.0 + (index * 150.0) + offset,
                  right: index.isEven ? -30 : null,
                  left: index.isOdd ? -30 : null,
                  child: Transform.rotate(
                    angle: floatController.value * 0.2,
                    child: Opacity(
                      opacity: 0.08,
                      child: Icon(
                        _getIcon(index),
                        size: 120 - (index * 10),
                        color: const Color(0xFFD2B48C),
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Decorative circles
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    // ignore: deprecated_member_use
                    const Color(0xFFD2B48C).withOpacity(0.15),
                    // ignore: deprecated_member_use
                    const Color(0xFFD2B48C).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    // ignore: deprecated_member_use
                    const Color(0xFF8B4513).withOpacity(0.12),
                    // ignore: deprecated_member_use
                    const Color(0xFF8B4513).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          child,
        ],
      ),
    );
  }
}
