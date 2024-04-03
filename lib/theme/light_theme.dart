import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(backgroundColor: Colors.deepOrange),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey[900]!,
    secondary: Colors.grey[800]!,
    tertiary: Colors.black,
  ),
);
