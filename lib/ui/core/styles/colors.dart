import 'package:flutter/material.dart';

import 'package:soco/core/models/roast_level.dart';

class AppColors {
  AppColors._();

  static const Color seed = Color(0xFFD7CCC8);

  // ===================
  // LIGHT MODE PALETTE
  // ===================
  static const Color lightPrimary = Color(0xFF655D5A);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightPrimaryContainer = Color(0xFFD7CCC8);
  static const Color lightOnPrimaryContainer = Color(0xFF5E5653);
  static const Color lightSecondary = Color(0xFF6D574F);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightSecondaryContainer = Color(0xFF876F67);
  static const Color lightOnSecondaryContainer = Color(0xFFFFFBFF);
  static const Color lightTertiary = Color(0xFF492C0F);
  static const Color lightOnTertiary = Color(0xFFFFFFFF);
  static const Color lightTertiaryContainer = Color(0xFF634223);
  static const Color lightOnTertiaryContainer = Color(0xFFDEB088);
  static const Color lightError = Color(0xFF922C26);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color lightErrorContainer = Color(0xFFB2443B);
  static const Color lightOnErrorContainer = Color(0xFFFFE2DE);
  static const Color lightSurface = Color(0xFFFDF8F8);
  static const Color lightOnSurface = Color(0xFF1C1B1B);
  static const Color lightOnSurfaceVariant = Color(0xFF444748);
  static const Color lightOutline = Color(0xFF747878);
  static const Color lightOutlineVariant = Color(0xFFC4C7C7);
  static const Color lightShadow = Color(0xFF000000);
  static const Color lightScrim = Color(0xFF000000);
  static const Color lightInverseSurface = Color(0xFF313030);
  static const Color lightOnInverseSurface = Color(0xFFF4F0EF);
  static const Color lightInversePrimary = Color(0xFFCFC4C0);

  static const Color lightPrimaryFixed = Color(0xFFECE0DC);
  static const Color lightPrimaryFixedDim = Color(0xFFCFC4C0);
  static const Color lightOnPrimaryFixed = Color(0xFF201A18);
  static const Color lightOnPrimaryFixedVariant = Color(0xFF4C4542);
  static const Color lightSecondaryFixed = Color(0xFFFADCD2);
  static const Color lightSecondaryFixedDim = Color(0xFFDDC1B7);
  static const Color lightOnSecondaryFixed = Color(0xFF271812);
  static const Color lightOnSecondaryFixedVariant = Color(0xFF56423B);
  static const Color lightTertiaryFixed = Color(0xFFFFDCC0);
  static const Color lightTertiaryFixedDim = Color(0xFFEDBD95);
  static const Color lightOnTertiaryFixed = Color(0xFF2D1600);
  static const Color lightOnTertiaryFixedVariant = Color(0xFF604021);

  static const Color lightSurfaceTint = Color(0xFF655D5A);
  static const Color lightSurfaceDim = Color(0xFFDDD9D8);
  static const Color lightSurfaceBright = Color(0xFFFDF8F8);
  static const Color lightSurfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainerLow = Color(0xFFF7F3F2);
  static const Color lightSurfaceContainer = Color(0xFFF1EDEC);
  static const Color lightSurfaceContainerHigh = Color(0xFFEBE7E6);
  static const Color lightSurfaceContainerHighest = Color(0xFFE5E2E1);

  // ==================
  // DARK MODE PALETTE
  // ==================
  static const Color darkPrimary = Color(0xFFF4E8E4);
  static const Color darkOnPrimary = Color(0xFF352F2D);
  static const Color darkPrimaryContainer = Color(0xFFD7CCC8);
  static const Color darkOnPrimaryContainer = Color(0xFF5E5653);
  static const Color darkSecondary = Color(0xFFDDC1B7);
  static const Color darkOnSecondary = Color(0xFF3E2C26);
  static const Color darkSecondaryContainer = Color(0xFFA58B82);
  static const Color darkOnSecondaryContainer = Color(0xFF33231C);
  static const Color darkTertiary = Color(0xFFEDBD95);
  static const Color darkOnTertiary = Color(0xFF472A0D);
  static const Color darkTertiaryContainer = Color(0xFF634223);
  static const Color darkOnTertiaryContainer = Color(0xFFDEB088);
  static const Color darkError = Color(0xFFFFB4AB);
  static const Color darkOnError = Color(0xFF650A0A);
  static const Color darkErrorContainer = Color(0xFFB2443B);
  static const Color darkOnErrorContainer = Color(0xFFFFE2DE);
  static const Color darkSurface = Color(0xFF141313);
  static const Color darkOnSurface = Color(0xFFE5E2E1);
  static const Color darkOnSurfaceVariant = Color(0xFFC4C7C7);
  static const Color darkOutline = Color(0xFF8E9192);
  static const Color darkOutlineVariant = Color(0xFF444748);
  static const Color darkShadow = Color(0xFF000000);
  static const Color darkScrim = Color(0xFF000000);
  static const Color darkInverseSurface = Color(0xFFE5E2E1);
  static const Color darkOnInverseSurface = Color(0xFF313030);
  static const Color darkInversePrimary = Color(0xFF655D5A);

  static const Color darkPrimaryFixed = Color(0xFFECE0DC);
  static const Color darkPrimaryFixedDim = Color(0xFFCFC4C0);
  static const Color darkOnPrimaryFixed = Color(0xFF201A18);
  static const Color darkOnPrimaryFixedVariant = Color(0xFF4C4542);
  static const Color darkSecondaryFixed = Color(0xFFFADCD2);
  static const Color darkSecondaryFixedDim = Color(0xFFDDC1B7);
  static const Color darkOnSecondaryFixed = Color(0xFF271812);
  static const Color darkOnSecondaryFixedVariant = Color(0xFF56423B);
  static const Color darkTertiaryFixed = Color(0xFFFFDCC0);
  static const Color darkTertiaryFixedDim = Color(0xFFEDBD95);
  static const Color darkOnTertiaryFixed = Color(0xFF2D1600);
  static const Color darkOnTertiaryFixedVariant = Color(0xFF604021);

  static const Color darkSurfaceTint = Color(0xFFCFC4C0);
  static const Color darkSurfaceDim = Color(0xFF141313);
  static const Color darkSurfaceBright = Color(0xFF3A3939);
  static const Color darkSurfaceContainerLowest = Color(0xFF0E0E0E);
  static const Color darkSurfaceContainerLow = Color(0xFF1C1B1B);
  static const Color darkSurfaceContainer = Color(0xFF201F1F);
  static const Color darkSurfaceContainerHigh = Color(0xFF2B2A2A);
  static const Color darkSurfaceContainerHighest = Color(0xFF353434);

  // ===================
  // ROAST LEVEL PALETTES
  // ===================
  // Light Mode
  static const Color roastLightBgLight = Color(0xFFE9DED6);
  static const Color roastLightTextLight = Color(0xFF8D5B4C);
  static const Color roastMediumBgLight = Color(0xFFECD7CA);
  static const Color roastMediumTextLight = Color(0xFF7E4B35);
  static const Color roastDarkBgLight = Color(0xFFD8CBC1);
  static const Color roastDarkTextLight = Color(0xFF5E463E);

  // Dark Mode
  static const Color roastLightBgDark = Color(0xFF8F7A6B);
  static const Color roastLightTextDark = Color(0xFFFBF0E8);
  static const Color roastMediumBgDark = Color(0xFF6B4B32);
  static const Color roastMediumTextDark = Color(0xFFFFE0CC);
  static const Color roastDarkBgDark = Color(0xFF433835);
  static const Color roastDarkTextDark = Color(0xFFE6D6D2);
}

class RoastColors extends ThemeExtension<RoastColors> {
  final Color lightBg;
  final Color lightText;
  final Color mediumBg;
  final Color mediumText;
  final Color darkBg;
  final Color darkText;

  const RoastColors({
    required this.lightBg,
    required this.lightText,
    required this.mediumBg,
    required this.mediumText,
    required this.darkBg,
    required this.darkText,
  });

  Color getBgColor(RoastLevel level) {
    switch (level) {
      case RoastLevel.light:
        return lightBg;
      case RoastLevel.medium:
        return mediumBg;
      case RoastLevel.dark:
        return darkBg;
    }
  }

  Color getTextColor(RoastLevel level) {
    switch (level) {
      case RoastLevel.light:
        return lightText;
      case RoastLevel.medium:
        return mediumText;
      case RoastLevel.dark:
        return darkText;
    }
  }

  @override
  RoastColors copyWith({
    Color? lightBg,
    Color? lightText,
    Color? mediumBg,
    Color? mediumText,
    Color? darkBg,
    Color? darkText,
  }) {
    return RoastColors(
      lightBg: lightBg ?? this.lightBg,
      lightText: lightText ?? this.lightText,
      mediumBg: mediumBg ?? this.mediumBg,
      mediumText: mediumText ?? this.mediumText,
      darkBg: darkBg ?? this.darkBg,
      darkText: darkText ?? this.darkText,
    );
  }

  @override
  RoastColors lerp(ThemeExtension<RoastColors>? other, double t) {
    if (other is! RoastColors) return this;
    return RoastColors(
      lightBg: Color.lerp(lightBg, other.lightBg, t)!,
      lightText: Color.lerp(lightText, other.lightText, t)!,
      mediumBg: Color.lerp(mediumBg, other.mediumBg, t)!,
      mediumText: Color.lerp(mediumText, other.mediumText, t)!,
      darkBg: Color.lerp(darkBg, other.darkBg, t)!,
      darkText: Color.lerp(darkText, other.darkText, t)!,
    );
  }
}

