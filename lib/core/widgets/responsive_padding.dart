import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final bool horizontal;
  final bool vertical;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.horizontal = true,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ? r.paddingHorizontal : 0,
        vertical: vertical ? r.paddingVertical : 0,
      ),
      child: child,
    );
  }
}
