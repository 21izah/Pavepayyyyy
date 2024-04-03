import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(backgroundColor: Colors.black),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey[200]!,
    secondary: Colors.grey[300]!,
    tertiary: Colors.white,
  ),
);
