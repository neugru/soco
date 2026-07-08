import 'package:flutter/material.dart';

import 'package:soco/core/models/brew_profile.dart';
import 'package:soco/ui/core/styles/colors.dart';
import 'package:soco/ui/core/styles/elevation.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/soco_icons.dart';

class BeanCard extends StatelessWidget {
  final BrewProfile profile;
  final bool isCompact;

  const BeanCard({
    super.key,
    required this.profile,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final roastColors = Theme.of(context).extension<RoastColors>()!;
    final roastBgColor = roastColors.getBgColor(profile.bean.roastLevel);
    final roastTextColor = roastColors.getTextColor(profile.bean.roastLevel);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppSizes.radius.large),
        boxShadow: AppElevation.shadows.low,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radius.large),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spacing.medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title, Brand, Star Rating
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title, Brand
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.bean.name,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppSizes.gap.extraSmall,
                        Text(
                          profile.bean.brand,
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  AppSizes.gap.small,
                  // Star Rating
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        SocoIcons.starRate,
                        color: Colors.amber,
                        size: 16,
                      ),
                      AppSizes.gap.extraSmall,
                      Text(
                        profile.rating.toStringAsFixed(1),
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              AppSizes.gap.small,
              // Strength Meter, Roast Level
              Wrap(
                spacing: AppSizes.spacing.large,
                runSpacing: AppSizes.spacing.small,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // Strength Meter
                  Wrap(
                    spacing: 2.0,
                    children: List.generate(5, (index) {
                      final isActive = index < profile.bean.strength;
                      final activeColor = colorScheme.primary;
                      final inactiveColor = activeColor.withValues(alpha: 0.16);

                      return Icon(
                        SocoIcons.coffeeBean,
                        size: 16,
                        color: isActive ? activeColor : inactiveColor,
                      );
                    }),
                  ),
                  // Roast Level Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: roastBgColor,
                      borderRadius: BorderRadius.circular(AppSizes.radius.small),
                    ),
                    child: Text(
                      '${profile.bean.roastLevel.displayName} Roast',
                      style: textTheme.bodySmall?.copyWith(
                        color: roastTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (!isCompact) ...[
                AppSizes.gap.small,
                // Equipment Details (Grinder & Machine)
                LayoutBuilder(
                  builder: (context, constraints) {
                    final textStyle = textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    );

                    // Calculate intrinsic widths
                    final machineNaturalWidth = _EquipmentBadge.calculateWidth(
                      profile.machine.displayName,
                      textStyle,
                    );
                    final grinderNaturalWidth = _EquipmentBadge.calculateWidth(
                      profile.grinder.displayName,
                      textStyle,
                    );
                    final gapWidth = AppSizes.spacing.small;
                    final contentAvailableWidth = (constraints.maxWidth - gapWidth).clamp(0.0, double.infinity);

                    final sizes = _EquipmentLayoutHelper.calculateWidths(
                      machineNaturalWidth: machineNaturalWidth,
                      grinderNaturalWidth: grinderNaturalWidth,
                      contentAvailableWidth: contentAvailableWidth,
                    );

                    return Row(
                      children: [
                        // Machine Badge
                        SizedBox(
                          width: sizes.machineWidth,
                          child: _EquipmentBadge(
                            icon: SocoIcons.coffeeMaker,
                            label: profile.machine.displayName,
                          ),
                        ),
                        SizedBox(width: gapWidth),
                        // Grinder Badge
                        SizedBox(
                          width: sizes.grinderWidth,
                          child: _EquipmentBadge(
                            icon: SocoIcons.grinder,
                            label: profile.grinder.displayName,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                AppSizes.gap.small,
                // Description
                Text(
                  profile.description,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSizes.gap.medium,
                // Recipes/Brewing Metrics (Dose, Yield, Grind Size, Time)
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: AppSizes.spacing.extraLarge,
                  runSpacing: AppSizes.spacing.medium,
                  children: [
                    _MetricColumn(
                      label: 'Dose',
                      value: '${profile.dose.toStringAsFixed(1).replaceAll('.0', '')}g',
                    ),
                    _MetricColumn(
                      label: 'Yield',
                      value: '${profile.brewYield.toStringAsFixed(1).replaceAll('.0', '')}g',
                    ),
                    _MetricColumn(
                      label: 'Grind',
                      value: profile.grindSize.toStringAsFixed(1).replaceAll('.0', ''),
                    ),
                    _MetricColumn(
                      label: 'Time',
                      value: '${profile.brewTimeSeconds}s',
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

}

class _EquipmentBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _EquipmentBadge({
    required this.icon,
    required this.label,
  });

  static const double horizontalPadding = 8.0;
  static const double verticalPadding = 4.0;
  static const double iconSize = 14.0;
  static const double gapWidth = 4.0;

  /// The total width of all non-text layout components (padding, icon, and gap).
  static const double extraWidth = (horizontalPadding * 2) + iconSize + gapWidth;

  /// Calculates the total unconstrained width needed to display the badge with a given [text] and [style].
  static double calculateWidth(String text, TextStyle? style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width + extraWidth;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSizes.radius.small),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: colorScheme.outline,
          ),
          const SizedBox(width: gapWidth),
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeSizingResult {
  final double machineWidth;
  final double grinderWidth;

  const _BadgeSizingResult({
    required this.machineWidth,
    required this.grinderWidth,
  });
}

class _EquipmentLayoutHelper {
  /// Calculates the final layout widths for the machine and grinder badges.
  ///
  /// * [machineNaturalWidth] represents the full, unconstrained (intrinsic) width
  ///   needed to render the machine badge without any text truncation.
  /// * [grinderNaturalWidth] represents the full, unconstrained (intrinsic) width
  ///   needed to render the grinder badge without any text truncation.
  /// * [contentAvailableWidth] is the total horizontal layout space available
  ///   for both badges combined.
  static _BadgeSizingResult calculateWidths({
    required double machineNaturalWidth,
    required double grinderNaturalWidth,
    required double contentAvailableWidth,
  }) {
    if (machineNaturalWidth + grinderNaturalWidth <= contentAvailableWidth) {
      // both badges fit with full size
      return _BadgeSizingResult(
        machineWidth: machineNaturalWidth,
        grinderWidth: grinderNaturalWidth,
      );
    }

    final halfWidth = contentAvailableWidth / 2;
    if (machineNaturalWidth > halfWidth && grinderNaturalWidth > halfWidth) {
      // both badges get exactly half the available space
      return _BadgeSizingResult(
        machineWidth: halfWidth,
        grinderWidth: halfWidth,
      );
    } else if (machineNaturalWidth <= halfWidth) {
      // grinder badge gets shrunk to available space
      // machine badge is not shrunk
      final machineWidth = machineNaturalWidth;
      return _BadgeSizingResult(
        machineWidth: machineWidth,
        grinderWidth: contentAvailableWidth - machineWidth,
      );
    } else {
      // machine badge gets shrunk to available space
      // grinder badge is not shrunk
      final grinderWidth = grinderNaturalWidth;
      return _BadgeSizingResult(
        machineWidth: contentAvailableWidth - grinderWidth,
        grinderWidth: grinderWidth,
      );
    }
  }
}

class _MetricColumn extends StatelessWidget {
  final String label;
  final String value;

  const _MetricColumn({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSizes.gap.extraSmall,
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
