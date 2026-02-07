import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final bool centerContent;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    if (r.isDesktop) {
      return Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: r.maxContentWidth),
          child: child,
        ),
      );
    }

    return child;
  }
}
