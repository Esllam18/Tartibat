import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/core/utils/responsive.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Base text style with responsive sizing
  static TextStyle _baseStyle(double size, FontWeight weight, Color color) {
    return GoogleFonts.cairo(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  // Headings (responsive)
  static TextStyle h1(BuildContext context) => _baseStyle(
        context.responsive.fontSize(28),
        FontWeight.bold,
        AppColors.textPrimary,
      );

  static TextStyle h2(BuildContext context) => _baseStyle(
        context.responsive.fontSize(24),
        FontWeight.bold,
        AppColors.textPrimary,
      );

  static TextStyle h3(BuildContext context) => _baseStyle(
        context.responsive.fontSize(20),
        FontWeight.bold,
        AppColors.textPrimary,
      );

  static TextStyle h4(BuildContext context) => _baseStyle(
        context.responsive.fontSize(18),
        FontWeight.bold,
        AppColors.textPrimary,
      );

  // Body Text
  static TextStyle bodyLarge(BuildContext context) => _baseStyle(
        context.responsive.fontSize(16),
        FontWeight.normal,
        AppColors.textPrimary,
      );

  static TextStyle bodyMedium(BuildContext context) => _baseStyle(
        context.responsive.fontSize(14),
        FontWeight.normal,
        AppColors.textPrimary,
      );

  static TextStyle bodySmall(BuildContext context) => _baseStyle(
        context.responsive.fontSize(12),
        FontWeight.normal,
        AppColors.textSecondary,
      );

  // Button Text
  static TextStyle button(BuildContext context) => _baseStyle(
        context.responsive.fontSize(16),
        FontWeight.bold,
        AppColors.textWhite,
      );

  // Prices
  static TextStyle price(BuildContext context) => _baseStyle(
        context.responsive.fontSize(18),
        FontWeight.bold,
        AppColors.primary,
      );

  // Captions
  static TextStyle caption(BuildContext context) => _baseStyle(
        context.responsive.fontSize(12),
        FontWeight.normal,
        AppColors.textSecondary,
      );

  // Static versions (for widgets that don't have context)
  static TextStyle get h1Static => GoogleFonts.cairo(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMediumStatic => GoogleFonts.cairo(
        fontSize: 14,
        color: AppColors.textPrimary,
      );

  static TextStyle get buttonStatic => GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textWhite,
      );

  static TextStyle get captionStatic => GoogleFonts.cairo(
        fontSize: 12,
        color: AppColors.textSecondary,
      );

  static TextStyle get h4Static => GoogleFonts.cairo(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySmallStatic => GoogleFonts.cairo(
        fontSize: 12,
        color: AppColors.textSecondary,
      );

  static TextStyle get h3Static => GoogleFonts.cairo(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );
}
