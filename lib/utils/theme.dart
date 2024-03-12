import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: const Color(0xff010409),
      onPrimary: Colors.white,
      secondary: const Color(0xff21262d),
      onSecondary: Colors.white,
      error: Colors.red.shade800,
      onError: Colors.white,
      background: const Color(0xff0d1117),
      onBackground: const Color(0xff727a84),
      surface: const Color(0xff0d1117),
      onSurface: const Color(0xff727a84),
    ),
    useMaterial3: true,
  );
}
