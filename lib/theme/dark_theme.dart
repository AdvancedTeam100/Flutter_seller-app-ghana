import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'TitilliumWeb',
  primaryColor: Color(0xFF1B7FED),
  brightness: Brightness.dark,
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
  highlightColor: Color(0xFF252525),
  hintColor: Color(0xFFc7c7c7),
  colorScheme : const ColorScheme.dark(primary: Color(0xFF64BDF9),
      secondary: Color(0xFF78BDFC),
      tertiary: Color(0xFF865C0A),
      tertiaryContainer: Color(0xFF6C7A8E),
      onTertiaryContainer: Color(0xFF0F5835),
      primaryContainer: Color(0xFF208458),
      secondaryContainer: Color(0xFFF2F2F2),
      surface: Color(0xFF00FF58),
      surfaceTint: Color(0xFF0087FF),
      onPrimary: Color(0xFF67AFFF),
      onSecondary: Color(0xFFFC9926)
  ),

  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
