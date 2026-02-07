import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  // Screen width and height
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // Device type checks
  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;

  // Responsive values based on screen size
  T responsive<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  // Responsive padding
  double get paddingHorizontal =>
      responsive(mobile: 16.0, tablet: 24.0, desktop: 32.0);

  double get paddingVertical =>
      responsive(mobile: 16.0, tablet: 20.0, desktop: 24.0);

  // Responsive font sizes
  double fontSize(double size) {
    if (isDesktop) return size * 1.2;
    if (isTablet) return size * 1.1;
    return size;
  }

  // Grid columns
  int get gridColumns => responsive(mobile: 2, tablet: 3, desktop: 4);

  // Max content width (for desktop)
  double get maxContentWidth => 1200;

  // Responsive spacing
  double spacing(double baseSpacing) {
    return responsive(
      mobile: baseSpacing,
      tablet: baseSpacing * 1.2,
      desktop: baseSpacing * 1.5,
    );
  }
}

// Extension for easy access
extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);
}
