import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/colors.dart';
import 'package:soco/ui/core/styles/elevation.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return _buildTheme(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.seed,
        brightness: Brightness.light,
      ).copyWith(
        primary: AppColors.lightPrimary,
        onPrimary: AppColors.lightOnPrimary,
        primaryContainer: AppColors.lightPrimaryContainer,
        onPrimaryContainer: AppColors.lightOnPrimaryContainer,
        secondary: AppColors.lightSecondary,
        onSecondary: AppColors.lightOnSecondary,
        secondaryContainer: AppColors.lightSecondaryContainer,
        onSecondaryContainer: AppColors.lightOnSecondaryContainer,
        tertiary: AppColors.lightTertiary,
        onTertiary: AppColors.lightOnTertiary,
        tertiaryContainer: AppColors.lightTertiaryContainer,
        onTertiaryContainer: AppColors.lightOnTertiaryContainer,
        error: AppColors.lightError,
        onError: AppColors.lightOnError,
        errorContainer: AppColors.lightErrorContainer,
        onErrorContainer: AppColors.lightOnErrorContainer,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightOnSurface,
        onSurfaceVariant: AppColors.lightOnSurfaceVariant,
        outline: AppColors.lightOutline,
        outlineVariant: AppColors.lightOutlineVariant,
        shadow: AppColors.lightShadow,
        scrim: AppColors.lightScrim,
        inverseSurface: AppColors.lightInverseSurface,
        onInverseSurface: AppColors.lightOnInverseSurface,
        inversePrimary: AppColors.lightInversePrimary,

        primaryFixed: AppColors.lightPrimaryFixed,
        primaryFixedDim: AppColors.lightPrimaryFixedDim,
        onPrimaryFixed: AppColors.lightOnPrimaryFixed,
        onPrimaryFixedVariant: AppColors.lightOnPrimaryFixedVariant,
        secondaryFixed: AppColors.lightSecondaryFixed,
        secondaryFixedDim: AppColors.lightSecondaryFixedDim,
        onSecondaryFixed: AppColors.lightOnSecondaryFixed,
        onSecondaryFixedVariant: AppColors.lightOnSecondaryFixedVariant,
        tertiaryFixed: AppColors.lightTertiaryFixed,
        tertiaryFixedDim: AppColors.lightTertiaryFixedDim,
        onTertiaryFixed: AppColors.lightOnTertiaryFixed,
        onTertiaryFixedVariant: AppColors.lightOnTertiaryFixedVariant,

        surfaceTint: AppColors.lightSurfaceTint,
        surfaceDim: AppColors.lightSurfaceDim,
        surfaceBright: AppColors.lightSurfaceBright,
        surfaceContainerLowest: AppColors.lightSurfaceContainerLowest,
        surfaceContainerLow: AppColors.lightSurfaceContainerLow,
        surfaceContainer: AppColors.lightSurfaceContainer,
        surfaceContainerHigh: AppColors.lightSurfaceContainerHigh,
        surfaceContainerHighest: AppColors.lightSurfaceContainerHighest,
      ),
      roastColors: const RoastColors(
        lightBg: AppColors.roastLightBgLight,
        lightText: AppColors.roastLightTextLight,
        mediumBg: AppColors.roastMediumBgLight,
        mediumText: AppColors.roastMediumTextLight,
        darkBg: AppColors.roastDarkBgLight,
        darkText: AppColors.roastDarkTextLight,
      ),
    );
  }

  static ThemeData get darkTheme {
    return _buildTheme(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.seed,
        brightness: Brightness.dark,
      ).copyWith(
        primary: AppColors.darkPrimary,
        onPrimary: AppColors.darkOnPrimary,
        primaryContainer: AppColors.darkPrimaryContainer,
        onPrimaryContainer: AppColors.darkOnPrimaryContainer,
        secondary: AppColors.darkSecondary,
        onSecondary: AppColors.darkOnSecondary,
        secondaryContainer: AppColors.darkSecondaryContainer,
        onSecondaryContainer: AppColors.darkOnSecondaryContainer,
        tertiary: AppColors.darkTertiary,
        onTertiary: AppColors.darkOnTertiary,
        tertiaryContainer: AppColors.darkTertiaryContainer,
        onTertiaryContainer: AppColors.darkOnTertiaryContainer,
        error: AppColors.darkError,
        onError: AppColors.darkOnError,
        errorContainer: AppColors.darkErrorContainer,
        onErrorContainer: AppColors.darkOnErrorContainer,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkOnSurface,
        onSurfaceVariant: AppColors.darkOnSurfaceVariant,
        outline: AppColors.darkOutline,
        outlineVariant: AppColors.darkOutlineVariant,
        shadow: AppColors.darkShadow,
        scrim: AppColors.darkScrim,
        inverseSurface: AppColors.darkInverseSurface,
        onInverseSurface: AppColors.darkOnInverseSurface,
        inversePrimary: AppColors.darkInversePrimary,

        primaryFixed: AppColors.darkPrimaryFixed,
        primaryFixedDim: AppColors.darkPrimaryFixedDim,
        onPrimaryFixed: AppColors.darkOnPrimaryFixed,
        onPrimaryFixedVariant: AppColors.darkOnPrimaryFixedVariant,
        secondaryFixed: AppColors.darkSecondaryFixed,
        secondaryFixedDim: AppColors.darkSecondaryFixedDim,
        onSecondaryFixed: AppColors.darkOnSecondaryFixed,
        onSecondaryFixedVariant: AppColors.darkOnSecondaryFixedVariant,
        tertiaryFixed: AppColors.darkTertiaryFixed,
        tertiaryFixedDim: AppColors.darkTertiaryFixedDim,
        onTertiaryFixed: AppColors.darkOnTertiaryFixed,
        onTertiaryFixedVariant: AppColors.darkOnTertiaryFixedVariant,

        surfaceTint: AppColors.darkSurfaceTint,
        surfaceDim: AppColors.darkSurfaceDim,
        surfaceBright: AppColors.darkSurfaceBright,
        surfaceContainerLowest: AppColors.darkSurfaceContainerLowest,
        surfaceContainerLow: AppColors.darkSurfaceContainerLow,
        surfaceContainer: AppColors.darkSurfaceContainer,
        surfaceContainerHigh: AppColors.darkSurfaceContainerHigh,
        surfaceContainerHighest: AppColors.darkSurfaceContainerHighest,
      ),
      roastColors: const RoastColors(
        lightBg: AppColors.roastLightBgDark,
        lightText: AppColors.roastLightTextDark,
        mediumBg: AppColors.roastMediumBgDark,
        mediumText: AppColors.roastMediumTextDark,
        darkBg: AppColors.roastDarkBgDark,
        darkText: AppColors.roastDarkTextDark,
      ),
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required RoastColors roastColors,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      extensions: <ThemeExtension<dynamic>>[roastColors],
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: AppStyles.textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer.withValues(alpha: 0.65),
        height: 64,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: colorScheme.onPrimaryContainer,
        backgroundColor: colorScheme.primaryContainer,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: Size(0, AppSizes.button.height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius.large),
          ),
          elevation: 0,
          textStyle: AppStyles.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: Size(0, AppSizes.button.height),
          side: BorderSide(color: colorScheme.primary, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius.large),
          ),
          textStyle: AppStyles.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: Size(0, AppSizes.button.height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius.large),
          ),
          textStyle: AppStyles.labelLarge,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        contentPadding: EdgeInsets.symmetric(
          horizontal: soco_sizes.AppSizes.input.paddingHorizontal,
          vertical: soco_sizes.AppSizes.input.paddingVertical,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.medium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.medium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius.medium),
          borderSide: BorderSide(color: colorScheme.primary, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius.medium),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        labelStyle: TextStyle(color: colorScheme.outline),
        hintStyle: TextStyle(color: colorScheme.outline),
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainer),
          elevation: const WidgetStatePropertyAll(AppElevation.high),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radius.medium),
            ),
          ),
        ),
      ),
    );
  }
}
