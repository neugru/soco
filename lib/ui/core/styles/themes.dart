import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/colors.dart';
import 'package:soco/ui/core/styles/elevation.dart';
import 'package:soco/ui/core/styles/sizes.dart' as soco_sizes;
import 'package:soco/ui/core/styles/typography.dart';

class SocoTheme {
  SocoTheme._();

  static ThemeData get lightTheme {
    return _buildTheme(
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: SocoColors.seed,
            brightness: Brightness.light,
          ).copyWith(
            primary: SocoColors.lightPrimary,
            onPrimary: SocoColors.lightOnPrimary,
            primaryContainer: SocoColors.lightPrimaryContainer,
            onPrimaryContainer: SocoColors.lightOnPrimaryContainer,
            secondary: SocoColors.lightSecondary,
            onSecondary: SocoColors.lightOnSecondary,
            secondaryContainer: SocoColors.lightSecondaryContainer,
            onSecondaryContainer: SocoColors.lightOnSecondaryContainer,
            tertiary: SocoColors.lightTertiary,
            onTertiary: SocoColors.lightOnTertiary,
            tertiaryContainer: SocoColors.lightTertiaryContainer,
            onTertiaryContainer: SocoColors.lightOnTertiaryContainer,
            error: SocoColors.lightError,
            onError: SocoColors.lightOnError,
            errorContainer: SocoColors.lightErrorContainer,
            onErrorContainer: SocoColors.lightOnErrorContainer,
            surface: SocoColors.lightSurface,
            onSurface: SocoColors.lightOnSurface,
            onSurfaceVariant: SocoColors.lightOnSurfaceVariant,
            outline: SocoColors.lightOutline,
            outlineVariant: SocoColors.lightOutlineVariant,
            shadow: SocoColors.lightShadow,
            scrim: SocoColors.lightScrim,
            inverseSurface: SocoColors.lightInverseSurface,
            onInverseSurface: SocoColors.lightOnInverseSurface,
            inversePrimary: SocoColors.lightInversePrimary,

            primaryFixed: SocoColors.lightPrimaryFixed,
            primaryFixedDim: SocoColors.lightPrimaryFixedDim,
            onPrimaryFixed: SocoColors.lightOnPrimaryFixed,
            onPrimaryFixedVariant: SocoColors.lightOnPrimaryFixedVariant,
            secondaryFixed: SocoColors.lightSecondaryFixed,
            secondaryFixedDim: SocoColors.lightSecondaryFixedDim,
            onSecondaryFixed: SocoColors.lightOnSecondaryFixed,
            onSecondaryFixedVariant: SocoColors.lightOnSecondaryFixedVariant,
            tertiaryFixed: SocoColors.lightTertiaryFixed,
            tertiaryFixedDim: SocoColors.lightTertiaryFixedDim,
            onTertiaryFixed: SocoColors.lightOnTertiaryFixed,
            onTertiaryFixedVariant: SocoColors.lightOnTertiaryFixedVariant,

            surfaceTint: SocoColors.lightSurfaceTint,
            surfaceDim: SocoColors.lightSurfaceDim,
            surfaceBright: SocoColors.lightSurfaceBright,
            surfaceContainerLowest: SocoColors.lightSurfaceContainerLowest,
            surfaceContainerLow: SocoColors.lightSurfaceContainerLow,
            surfaceContainer: SocoColors.lightSurfaceContainer,
            surfaceContainerHigh: SocoColors.lightSurfaceContainerHigh,
            surfaceContainerHighest: SocoColors.lightSurfaceContainerHighest,
          ),
      roastColors: const RoastColors(
        lightBg: SocoColors.roastLightBgLight,
        lightText: SocoColors.roastLightTextLight,
        mediumBg: SocoColors.roastMediumBgLight,
        mediumText: SocoColors.roastMediumTextLight,
        darkBg: SocoColors.roastDarkBgLight,
        darkText: SocoColors.roastDarkTextLight,
      ),
    );
  }

  static ThemeData get darkTheme {
    return _buildTheme(
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: SocoColors.seed,
            brightness: Brightness.dark,
          ).copyWith(
            primary: SocoColors.darkPrimary,
            onPrimary: SocoColors.darkOnPrimary,
            primaryContainer: SocoColors.darkPrimaryContainer,
            onPrimaryContainer: SocoColors.darkOnPrimaryContainer,
            secondary: SocoColors.darkSecondary,
            onSecondary: SocoColors.darkOnSecondary,
            secondaryContainer: SocoColors.darkSecondaryContainer,
            onSecondaryContainer: SocoColors.darkOnSecondaryContainer,
            tertiary: SocoColors.darkTertiary,
            onTertiary: SocoColors.darkOnTertiary,
            tertiaryContainer: SocoColors.darkTertiaryContainer,
            onTertiaryContainer: SocoColors.darkOnTertiaryContainer,
            error: SocoColors.darkError,
            onError: SocoColors.darkOnError,
            errorContainer: SocoColors.darkErrorContainer,
            onErrorContainer: SocoColors.darkOnErrorContainer,
            surface: SocoColors.darkSurface,
            onSurface: SocoColors.darkOnSurface,
            onSurfaceVariant: SocoColors.darkOnSurfaceVariant,
            outline: SocoColors.darkOutline,
            outlineVariant: SocoColors.darkOutlineVariant,
            shadow: SocoColors.darkShadow,
            scrim: SocoColors.darkScrim,
            inverseSurface: SocoColors.darkInverseSurface,
            onInverseSurface: SocoColors.darkOnInverseSurface,
            inversePrimary: SocoColors.darkInversePrimary,

            primaryFixed: SocoColors.darkPrimaryFixed,
            primaryFixedDim: SocoColors.darkPrimaryFixedDim,
            onPrimaryFixed: SocoColors.darkOnPrimaryFixed,
            onPrimaryFixedVariant: SocoColors.darkOnPrimaryFixedVariant,
            secondaryFixed: SocoColors.darkSecondaryFixed,
            secondaryFixedDim: SocoColors.darkSecondaryFixedDim,
            onSecondaryFixed: SocoColors.darkOnSecondaryFixed,
            onSecondaryFixedVariant: SocoColors.darkOnSecondaryFixedVariant,
            tertiaryFixed: SocoColors.darkTertiaryFixed,
            tertiaryFixedDim: SocoColors.darkTertiaryFixedDim,
            onTertiaryFixed: SocoColors.darkOnTertiaryFixed,
            onTertiaryFixedVariant: SocoColors.darkOnTertiaryFixedVariant,

            surfaceTint: SocoColors.darkSurfaceTint,
            surfaceDim: SocoColors.darkSurfaceDim,
            surfaceBright: SocoColors.darkSurfaceBright,
            surfaceContainerLowest: SocoColors.darkSurfaceContainerLowest,
            surfaceContainerLow: SocoColors.darkSurfaceContainerLow,
            surfaceContainer: SocoColors.darkSurfaceContainer,
            surfaceContainerHigh: SocoColors.darkSurfaceContainerHigh,
            surfaceContainerHighest: SocoColors.darkSurfaceContainerHighest,
          ),
      roastColors: const RoastColors(
        lightBg: SocoColors.roastLightBgDark,
        lightText: SocoColors.roastLightTextDark,
        mediumBg: SocoColors.roastMediumBgDark,
        mediumText: SocoColors.roastMediumTextDark,
        darkBg: SocoColors.roastDarkBgDark,
        darkText: SocoColors.roastDarkTextDark,
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
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: SocoStyles.textTheme.apply(
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
        scrolledUnderElevation: 0.0,
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
          minimumSize: Size(0, soco_sizes.button.height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(soco_sizes.radius.round),
          ),
          textStyle: SocoStyles.textTheme.labelLarge,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: Size(0, soco_sizes.button.height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(soco_sizes.radius.round),
          ),
          textStyle: SocoStyles.textTheme.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: Size(0, soco_sizes.button.height),
          side: BorderSide(
            color: colorScheme.outline,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(soco_sizes.radius.round),
          ),
          textStyle: SocoStyles.textTheme.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: Size(0, soco_sizes.button.height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(soco_sizes.radius.round),
          ),
          textStyle: SocoStyles.textTheme.labelLarge,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        contentPadding: EdgeInsets.symmetric(
          horizontal: soco_sizes.input.paddingHorizontal,
          vertical: soco_sizes.input.paddingVertical,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(soco_sizes.radius.large),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(soco_sizes.radius.large),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(soco_sizes.radius.large),
          borderSide: BorderSide(color: colorScheme.primary, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(soco_sizes.radius.large),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(soco_sizes.radius.large),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        labelStyle: TextStyle(color: colorScheme.outline),
        hintStyle: TextStyle(color: colorScheme.outline),
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainer),
          elevation: const WidgetStatePropertyAll(SocoElevation.high),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(soco_sizes.radius.medium),
            ),
          ),
        ),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: colorScheme.surfaceContainerHigh,
        elevation: SocoElevation.high,
        surfaceTintColor: Colors.transparent,
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(soco_sizes.radius.medium),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.inverseSurface,
        actionTextColor: colorScheme.inversePrimary,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(soco_sizes.radius.medium),
        ),
        contentTextStyle: TextStyle(
          color: colorScheme.onInverseSurface,
        ),
      ),
    );
  }
}
