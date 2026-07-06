import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/colors.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/typography.dart';

class AppTheme {
  AppTheme._();

  /// Light Theme Definition
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
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

      // TODO
      scaffoldBackgroundColor: AppColors.lightSurface,
      textTheme: AppStyles.textTheme.apply(
        bodyColor: AppColors.lightOnSurface,
        displayColor: AppColors.lightOnSurface,
      ),

      // TODO check NavBar design
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.lightSurfaceContainer.withValues(alpha: 0.65),
        height: 64,
      ),

      // FloatingActionButton Theme
      // TODO
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: AppColors.lightOnPrimaryContainer,
        backgroundColor: AppColors.lightPrimaryContainer,
      ),

      // AppBar Theme
      // TODO
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.lightOnSurface),
        titleTextStyle: TextStyle(
          color: AppColors.lightOnSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Elevated Button Theme (Primary Buttons)
      // TODO
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: AppColors.lightOnPrimary,
          minimumSize: Size.fromHeight(soco_sizes.AppSizes.button.height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.medium),
          ),
          elevation: 0,
          textStyle: AppStyles.labelLarge,
        ),
      ),

      // Outlined Button Theme (Secondary Buttons)
      // TODO
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightPrimary,
          minimumSize: Size.fromHeight(soco_sizes.AppSizes.button.height),
          side: const BorderSide(color: AppColors.lightPrimary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.medium),
          ),
          textStyle: AppStyles.labelLarge,
        ),
      ),

      // Input Decoration Theme (Text Fields / Inputs)
      // TODO
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurfaceContainerHighest.withValues(alpha: 0.3),
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
          borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.medium),
          borderSide: const BorderSide(color: AppColors.lightPrimary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.medium),
          borderSide: const BorderSide(color: AppColors.lightError, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppColors.lightOutline),
        hintStyle: const TextStyle(color: AppColors.lightOutline),
      ),
    );
  }

  /// Dark Theme Definition
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
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

      // TODO
      scaffoldBackgroundColor: AppColors.darkSurface,
      textTheme: AppStyles.textTheme.apply(
        bodyColor: AppColors.darkOnSurface,
        displayColor: AppColors.darkOnSurface,
      ),

      // TODO check NavBar design
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.darkSurfaceContainer.withValues(alpha: 0.65),
        height: 64,
      ),

      // FloatingActionButton Theme
      // TODO
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: AppColors.darkOnPrimaryContainer,
        backgroundColor: AppColors.darkPrimaryContainer,
      ),

      // AppBar Theme
      // TODO
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.darkOnSurface),
        titleTextStyle: TextStyle(
          color: AppColors.darkOnSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Elevated Button Theme (Primary Buttons)
      // TODO
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: AppColors.darkOnPrimary,
          minimumSize: Size.fromHeight(soco_sizes.AppSizes.button.height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.medium),
          ),
          elevation: 0,
          textStyle: AppStyles.labelLarge,
        ),
      ),

      // Outlined Button Theme (Secondary Buttons)
      // TODO
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkPrimary,
          minimumSize: Size.fromHeight(soco_sizes.AppSizes.button.height),
          side: const BorderSide(color: AppColors.darkPrimary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.medium),
          ),
          textStyle: AppStyles.labelLarge,
        ),
      ),

      // Input Decoration Theme (Text Fields / Inputs)
      // TODO
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceContainerHighest.withValues(alpha: 0.15),
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
          borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.medium),
          borderSide: const BorderSide(color: AppColors.darkPrimary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.medium),
          borderSide: const BorderSide(color: AppColors.darkError, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppColors.darkOutline),
        hintStyle: const TextStyle(color: AppColors.darkOutline),
      ),
    );
  }
}
