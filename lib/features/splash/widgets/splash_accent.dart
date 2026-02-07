import 'package:flutter/material.dart';

class SplashAccent extends StatelessWidget {
  const SplashAccent({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.85,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _line(),
          const SizedBox(width: 10),
          const Icon(Icons.circle, size: 6, color: Colors.white),
          const SizedBox(width: 10),
          _line(),
        ],
      ),
    );
  }

  Widget _line() =>
      Container(width: 34, height: 1.2, color: Colors.white.withOpacity(.55));
}
