import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double textScaleFactor;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    final safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    final safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;
    textScaleFactor = _mediaQueryData.textScaleFactor;
  }
}

// Helper functions
double getWidth(double percentage) {
  return SizeConfig.blockSizeHorizontal * percentage;
}

double getHeight(double percentage) {
  return SizeConfig.blockSizeVertical * percentage;
}

double getFontSize(double baseFontSize) {
  return baseFontSize * SizeConfig.textScaleFactor;
}
