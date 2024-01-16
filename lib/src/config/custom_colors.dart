import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(255, 255, 255, 0.5),
  100: const Color.fromRGBO(255, 255, 255, 0.1),
  200: const Color.fromRGBO(255, 255, 255, 0.2),
  300: const Color.fromRGBO(255, 255, 255, 0.3),
  400: const Color.fromRGBO(255, 255, 255, 0.4),
  500: const Color.fromRGBO(255, 255, 255, 0.5),
  600: const Color.fromRGBO(255, 255, 255, 0.6),
  700: const Color.fromRGBO(255, 255, 255, 0.7),
  800: const Color.fromRGBO(255, 255, 255, 0.8),
  900: const Color.fromRGBO(255, 255, 255, 0.9),
};

abstract class CustomColors {
  static Color customConstrastColors =
      MaterialColor(0xffC03221, _swatchOpacity);
  static Color customSecondaryColor = Colors.red.shade700;
  static MaterialColor customSwatchColor =
      MaterialColor(0XFF111314, _swatchOpacity);
}
