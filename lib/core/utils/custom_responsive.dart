import 'package:flutter/material.dart';

class CustomResponsive {
  CustomResponsive._();

  // * Variables
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  /// Controls size of device
  static Size _size = const Size(0, 0);
  static set size(Size value) => _size = value;

  // * Getters
  // * ----------------------------------------------------------------------------------------------------------------
  // * ----------------------------------------------------------------------------------------------------------------

  static double get width => _size.width;

  static double get height => _size.height;

  static bool get isMobile => _size.width < 800;

  static bool get isTablet => _size.width < 1100 && _size.width >= 800;

  static bool get isDesktop => _size.width >= 1100 && _size.width < 1920;

  static bool get isUltraWideDesktop => _size.width >= 1920;

  static bool get isDesktopOrUltra => isDesktop || isUltraWideDesktop;
}
