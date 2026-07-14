import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocoStyles {
  SocoStyles._();

  static final String? _fontLora = GoogleFonts.lora().fontFamily;
  static final String? _fontOutfit = GoogleFonts.outfit().fontFamily;

  static final TextStyle _displayLarge = TextStyle(
    fontFamily: _fontLora,
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static final TextStyle _displayMedium = TextStyle(
    fontFamily: _fontLora,
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
  );

  static final TextStyle _displaySmall = TextStyle(
    fontFamily: _fontLora,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
  );

  static final TextStyle _headlineLarge = TextStyle(
    fontFamily: _fontLora,
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.25,
  );

  static final TextStyle _headlineMedium = TextStyle(
    fontFamily: _fontLora,
    fontSize: 28,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.29,
  );

  static final TextStyle _headlineSmall = TextStyle(
    fontFamily: _fontLora,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.33,
  );

  static final TextStyle _bodyLarge = TextStyle(
    fontFamily: _fontOutfit,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static final TextStyle _bodyMedium = TextStyle(
    fontFamily: _fontOutfit,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static final TextStyle _bodySmall = TextStyle(
    fontFamily: _fontOutfit,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  static final TextStyle _labelLarge = TextStyle(
    fontFamily: _fontOutfit,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static final TextStyle _labelMedium = TextStyle(
    fontFamily: _fontOutfit,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  );

  static final TextStyle _labelSmall = TextStyle(
    fontFamily: _fontOutfit,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );

  static final TextStyle _titleLarge = TextStyle(
    fontFamily: _fontLora,
    fontSize: 22,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.27,
  );

  static final TextStyle _titleMedium = TextStyle(
    fontFamily: _fontOutfit,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static final TextStyle _titleSmall = TextStyle(
    fontFamily: _fontOutfit,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );

  /// Generates a standardized TextTheme to pass into ThemeData.
  static TextTheme get textTheme {
    // Using a getter instead of a static final field ensures that updates to the
    // text styles are correctly evaluated and applied during Hot Reload.
    return TextTheme(
      displayLarge: _displayLarge,
      displayMedium: _displayMedium,
      displaySmall: _displaySmall,
      headlineLarge: _headlineLarge,
      headlineMedium: _headlineMedium,
      headlineSmall: _headlineSmall,
      bodyLarge: _bodyLarge,
      bodyMedium: _bodyMedium,
      bodySmall: _bodySmall,
      labelLarge: _labelLarge,
      labelMedium: _labelMedium,
      labelSmall: _labelSmall,
      titleLarge: _titleLarge,
      titleMedium: _titleMedium,
      titleSmall: _titleSmall,
    );
  }
}
