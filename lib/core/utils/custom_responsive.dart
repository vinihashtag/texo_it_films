import 'package:flutter/material.dart';

class CustomResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const CustomResponsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        // * If our width is more than 1100 then we consider it a desktop
        if (width >= 1100) {
          return desktop;
        }

        // * If width it less then 1100 and more then 850 we consider it as tablet
        else if (width >= 800) {
          return tablet ?? mobile;
        }

        // * Or less then that we called it mobile
        return mobile;
      },
    );
  }
}
