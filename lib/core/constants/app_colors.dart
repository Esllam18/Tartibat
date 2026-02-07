import 'package:flutter/material.dart';

/// App-wide color palette - Teal & Gold theme for premium furniture marketplace
class AppColors {
  AppColors._();

  // Primary - Deep Teal (Trust & Premium)
  static const Color primary = Color(0xFF1B7F79);
  static const Color primaryLight = Color(0xFF4DA9A3);
  static const Color primaryDark = Color(0xFF0F5651);

  // Secondary - Antique Gold (Luxury)
  static const Color secondary = Color(0xFFD4AF37);
  static const Color secondaryLight = Color(0xFFE5C864);
  static const Color secondaryDark = Color(0xFFB8941F);

  // Accent - Warm Terracotta
  static const Color accent = Color(0xFFE8985E);
  static const Color accentLight = Color(0xFFFAB896);

  // Backgrounds
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFFF1F3F5);

  // Text
  static const Color textPrimary = Color(0xFF2C2416);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textDisabled = Color(0xFFADB5BD);

  // Status
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFDC3545);
  static const Color info = Color(0xFF17A2B8);

  // Product Status
  static const Color statusPending = Color(0xFFFFA726);
  static const Color statusApproved = Color(0xFF66BB6A);
  static const Color statusRejected = Color(0xFFEF5350);

  // Shadows
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [success, Color(0xFF81C784)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
