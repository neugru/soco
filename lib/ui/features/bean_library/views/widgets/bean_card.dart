import 'package:flutter/material.dart';

import 'package:soco/core/models/brew_profile.dart';
import 'package:soco/ui/core/styles/colors.dart';
import 'package:soco/ui/core/styles/elevation.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/soco_icons.dart';

class BeanCard extends StatelessWidget {
  final BrewProfile profile;

  const BeanCard({
    super.key,
    required this.profile,
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
                      final isActive = index < profile.strength;
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
              AppSizes.gap.small,
              // Equipment Details (Grinder & Machine)
              Wrap(
                spacing: AppSizes.spacing.small,
                runSpacing: AppSizes.spacing.small,
                children: [
                  // Machine Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppSizes.radius.small),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          SocoIcons.coffeeMaker,
                          size: 14,
                          color: colorScheme.outline,
                        ),
                        AppSizes.gap.extraSmall,
                        Flexible(
                          child: Text(
                            profile.machine.displayName,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Grinder Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppSizes.radius.small),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          SocoIcons.grinder,
                          size: 14,
                          color: colorScheme.outline,
                        ),
                        AppSizes.gap.extraSmall,
                        Flexible(
                          child: Text(
                            profile.grinder.displayName,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
              // Grind Size
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: AppSizes.spacing.small,
                runSpacing: AppSizes.spacing.small,
                children: [
                  Wrap(
                    spacing: AppSizes.spacing.small,
                    runSpacing: AppSizes.spacing.small,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(AppSizes.radius.small),
                        ),
                        child: Text(
                          'Grind: ${profile.grindSize.toStringAsFixed(2)}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
