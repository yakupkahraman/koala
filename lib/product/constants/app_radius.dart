import 'package:flutter/widgets.dart';

class AppRadius {
  static const double primary = 36.0;
  static const double secondary = 20.0;

  static const BorderRadius primaryCircular = BorderRadius.all(
    Radius.circular(primary),
  );

  static const BorderRadius secondaryCircular = BorderRadius.all(
    Radius.circular(secondary),
  );

  static const BorderRadius primaryBottom = BorderRadius.only(
    bottomLeft: Radius.circular(primary),
    bottomRight: Radius.circular(primary),
  );

  static const BorderRadius secondaryBottom = BorderRadius.only(
    bottomLeft: Radius.circular(secondary),
    bottomRight: Radius.circular(secondary),
  );
}
