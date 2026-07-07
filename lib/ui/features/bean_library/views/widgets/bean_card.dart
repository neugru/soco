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
              // Title, Brand & Origin
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.bean.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        AppSizes.gap.extraSmall,
                        Text(
                          '${profile.bean.brand} • ${profile.bean.origin}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSizes.gap.small,
                  // Strength Meter
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      final isActive = index < profile.strength;
                      final activeColor = colorScheme.primary;
                      final inactiveColor = colorScheme.primary.withValues(alpha: 0.16);

                      return Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Icon(
                          SocoIcons.coffeeBean,
                          size: 14,
                          color: isActive ? activeColor : inactiveColor,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              AppSizes.gap.small,
              // Equipment Details (Grinder & Machine)
              Row(
                children: [
                  Icon(SocoIcons.grinder, size: 14, color: colorScheme.outline),
                  AppSizes.gap.extraSmall,
                  Expanded(
                    child: Text(
                      'Grinder: ${profile.grinder.displayName}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AppSizes.gap.small,
                  Icon(SocoIcons.coffeeMaker, size: 14, color: colorScheme.outline),
                  AppSizes.gap.extraSmall,
                  Expanded(
                    child: Text(
                      'Machine: ${profile.machine.displayName}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              AppSizes.gap.small,
              // Description
              Text(
                profile.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              AppSizes.gap.medium,
              // Footer: roast badge, grind size badge & star rating
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
                          color: roastBgColor,
                          borderRadius: BorderRadius.circular(AppSizes.radius.small),
                        ),
                        child: Text(
                          profile.bean.roastLevel.displayName,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: roastTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(AppSizes.radius.small),
                        ),
                        child: Text(
                          'Grind: ${profile.grindSize.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
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
