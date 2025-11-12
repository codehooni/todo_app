import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Color(0xFF3274F6),
    secondary: Color(0xFF00BFFF),
    tertiary: Color(0xFFFF00FF),
    surface: Color(0xFAFAFBFF), // 거의 흰색
    surfaceContainer: Color(0xFFFFFFFF), // 밝은 회색
    surfaceContainerHigh: Color(0xFFE8E8E8), // 더 어두운 회색
    onSurface: Color(0xFF001A33), // 진한 파란색
    onSurfaceVariant: Color(0xFF95A0C6), // 회색
    inverseSurface: Color(0xFF132973), // 다크 배경
    onInverseSurface: Color(0xFFFFFFFF), // 흰색
    shadow: Color(0xFF95A0C6),
  ),
);
