import 'package:flutter/material.dart';

final class AppPadding {
  static const double primary = 16.0;

  static const zero = EdgeInsets.zero;
  static const primaryAll = EdgeInsets.all(primary);
  static const primaryVertical = EdgeInsets.symmetric(vertical: primary);
  static const primaryHorizontal = EdgeInsets.symmetric(horizontal: primary);

  // Bottom Navigation Bar padding
  static const EdgeInsets bottomNavBarPadding = EdgeInsets.only(
    top: 10,
    bottom: 40,
    left: 16,
    right: 16,
  );
}
