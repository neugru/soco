import 'package:flutter/material.dart';

import 'package:soco/core/models/brew_profile.dart';
import 'package:soco/ui/core/styles/colors.dart';
import 'package:soco/ui/core/styles/elevation.dart';
import 'package:soco/ui/core/styles/metrics.dart' as soco_metrics;
import 'package:soco/ui/core/styles/icons.dart';

/// Renders a card display for a single brew profile.
/// Supports selection modes, collapsible details, and equipment badges.
class BeanCard extends StatelessWidget {
  /// The active brew profile data.
  final BrewProfile profile;

  /// Whether the card is currently expanded to show details.
  final bool isExpanded;

  /// Whether the card is currently in selection/batch mode.
  final bool isSelectionMode;

  /// Whether this specific card is currently selected.
  final bool isSelected;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  /// Callback when the card is long pressed.
  final VoidCallback? onLongPress;

  /// Callback when the bean is selected from the popup menu.
  final VoidCallback? onSelect;

  /// Callback when the bean is deleted from the library.
  final VoidCallback? onDelete;

  /// Callback when the bean details are shared.
  final VoidCallback? onShare;

  const BeanCard({
    super.key,
    required this.profile,
    this.isExpanded = false,
    this.isSelectionMode = false,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
    this.onSelect,
    this.onDelete,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity, // make the card fill the whole width of its parent
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(soco_metrics.radius.large),
        boxShadow: SocoElevation.shadows.low,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(soco_metrics.radius.large),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Padding(
              padding: EdgeInsets.all(soco_metrics.spacing.medium),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CardHeader(
                          profile: profile,
                          isSelectionMode: isSelectionMode,
                          onDelete: onDelete,
                          onShare: onShare,
                          onSelect: onSelect,
                        ),
                        soco_metrics.verticalBox.small,
                        _RoastStrengthRow(profile: profile),
                        if (isExpanded) ...[
                          soco_metrics.verticalBox.small,
                          _EquipmentBadgesRow(profile: profile),
                          if (profile.description != null && profile.description!.trim().isNotEmpty) ...[
                            soco_metrics.verticalBox.small,
                            Text(
                              profile.description!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          soco_metrics.verticalBox.medium,
                          _BrewMetricsRow(profile: profile),
                        ],
                      ],
                    ),
                  ),
                  if (isSelectionMode) ...[
                    soco_metrics.horizontalBox.medium,
                    Icon(
                      isSelected ? SocoIcons.checkBox : SocoIcons.checkBoxOutlined,
                      color: isSelected ? colorScheme.primary : colorScheme.outline,
                      size: soco_metrics.icon.large,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Renders the title and brand header block of the bean card,
/// along with the context popup menu button when not in selection mode.
class _CardHeader extends StatelessWidget {
  /// The active brew profile data.
  final BrewProfile profile;

  /// Whether the card is currently in selection/batch mode.
  final bool isSelectionMode;

  /// Callback when the bean is deleted from the library.
  final VoidCallback? onDelete;

  /// Callback when the bean details are shared.
  final VoidCallback? onShare;

  /// Callback when the bean is selected.
  final VoidCallback? onSelect;

  const _CardHeader({
    required this.profile,
    required this.isSelectionMode,
    this.onDelete,
    this.onShare,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              soco_metrics.verticalBox.xSmall,
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
        soco_metrics.horizontalBox.small,
        if (!isSelectionMode) ...[
          _CardContextMenu(
            onShare: onShare,
            onSelect: onSelect,
            onDelete: onDelete,
          ),
        ],
      ],
    );
  }
}

/// Renders the strength meter (coffee beans icons) and the roast level badge.
class _RoastStrengthRow extends StatelessWidget {
  /// The active brew profile data.
  final BrewProfile profile;

  const _RoastStrengthRow({
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final roastColors = Theme.of(context).extension<RoastColors>()!;
    final roastBgColor = profile.bean.roastLevel != null ? roastColors.getBgColor(profile.bean.roastLevel!) : null;
    final roastTextColor = profile.bean.roastLevel != null ? roastColors.getTextColor(profile.bean.roastLevel!) : null;

    return Row(
      spacing: soco_metrics.spacing.large,
      children: [
        // Strength Meter
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 2,
          children: List.generate(5, (index) {
            final isActive = index < profile.bean.strength;
            final activeColor = colorScheme.primary;
            final inactiveColor = activeColor.withValues(alpha: 0.16);

            return Icon(
              SocoIcons.coffeeBean,
              size: soco_metrics.icon.small,
              color: isActive ? activeColor : inactiveColor,
            );
          }),
        ),
        // Roast Level Badge
        if (profile.bean.roastLevel != null)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: soco_metrics.spacing.small,
              vertical: soco_metrics.spacing.xSmall,
            ),
            decoration: BoxDecoration(
              color: roastBgColor,
              borderRadius: BorderRadius.circular(soco_metrics.radius.small),
            ),
            child: Text(
              '${profile.bean.roastLevel!.displayName} Roast',
              style: textTheme.bodySmall?.copyWith(
                color: roastTextColor,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}

/// Renders the equipment details (machine and optional grinder badges) with adaptive layout.
class _EquipmentBadgesRow extends StatelessWidget {
  /// The active brew profile data.
  final BrewProfile profile;

  const _EquipmentBadgesRow({
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
        );

        // Calculate intrinsic width for machine
        final machineNaturalWidth = _EquipmentBadge.calculateWidth(
          profile.machine.displayName,
          textStyle,
        );

        // If grinder is null, only render the machine badge
        if (profile.grinder == null) {
          final machineWidth = machineNaturalWidth.clamp(0.0, constraints.maxWidth);
          return Row(
            children: [
              SizedBox(
                width: machineWidth,
                child: _EquipmentBadge(
                  icon: SocoIcons.coffeeMaker,
                  label: profile.machine.displayName,
                ),
              ),
            ],
          );
        }

        // Calculate intrinsic widths for grinder
        final grinderNaturalWidth = _EquipmentBadge.calculateWidth(
          profile.grinder!.displayName,
          textStyle,
        );
        final gapWidth = soco_metrics.spacing.small;
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
                label: profile.grinder!.displayName,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Renders the brewing metrics (dose, yield, grind size, and brew time).
class _BrewMetricsRow extends StatelessWidget {
  /// The active brew profile data.
  final BrewProfile profile;

  const _BrewMetricsRow({
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: soco_metrics.spacing.xLarge,
      runSpacing: soco_metrics.spacing.medium,
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
    );
  }
}

/// Renders a small badge showing equipment name and icon.
class _EquipmentBadge extends StatelessWidget {
  /// The icon representing the type of equipment.
  final IconData icon;

  /// The label displaying the equipment name.
  final String label;

  const _EquipmentBadge({
    required this.icon,
    required this.label,
  });

  static final double horizontalPadding = soco_metrics.spacing.small;
  static final double verticalPadding = soco_metrics.spacing.xSmall;
  static final double iconSize = soco_metrics.icon.xSmall;
  static final double gapWidth = soco_metrics.spacing.xSmall;

  /// The total width of all non-text layout components (padding, icon, and gap).
  static final double extraWidth = (horizontalPadding * 2) + iconSize + gapWidth;

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
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(soco_metrics.radius.small),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: colorScheme.outline,
          ),
          SizedBox(width: gapWidth),
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

/// Holds the sizing widths returned by the equipment layout helper.
class _BadgeSizingResult {
  /// The final calculated layout width for the machine badge.
  final double machineWidth;

  /// The final calculated layout width for the grinder badge.
  final double grinderWidth;

  const _BadgeSizingResult({
    required this.machineWidth,
    required this.grinderWidth,
  });
}

/// Helper class to distribute available width between machine and grinder badges.
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

/// Renders a single metrics column inside the metrics block.
class _MetricColumn extends StatelessWidget {
  /// The label of the metric column (e.g., Dose).
  final String label;

  /// The text value of the metric column (e.g., 18g).
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
        soco_metrics.verticalBox.xSmall,
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

/// Actions available in the context menu of a [BeanCard].
enum BeanCardAction {
  share(
    icon: SocoIcons.share,
    label: 'Share',
  ),
  select(
    icon: SocoIcons.checkBox,
    label: 'Select',
  ),
  delete(
    icon: SocoIcons.deleteOutline,
    label: 'Delete',
  );

  /// The icon representing this action.
  final IconData icon;

  /// The localized label text for this action.
  final String label;

  const BeanCardAction({
    required this.icon,
    required this.label,
  });
}

/// Renders the context popup menu button for a [BeanCard] using strongly typed actions.
class _CardContextMenu extends StatelessWidget {
  /// Callback when the share action is selected.
  final VoidCallback? onShare;

  /// Callback when the select action is selected.
  final VoidCallback? onSelect;

  /// Callback when the delete action is selected.
  final VoidCallback? onDelete;

  const _CardContextMenu({
    this.onShare,
    this.onSelect,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<BeanCardAction>(
      icon: Icon(SocoIcons.moreVert, size: soco_metrics.icon.medium),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onSelected: (action) {
        switch (action) {
          case BeanCardAction.share:
            onShare?.call();
          case BeanCardAction.select:
            onSelect?.call();
          case BeanCardAction.delete:
            onDelete?.call();
        }
      },
      itemBuilder: (context) => BeanCardAction.values.map((action) {
        return PopupMenuItem<BeanCardAction>(
          value: action,
          // Use Builder to resolve the theme dynamically so open items adapt to live dark mode toggles.
          child: Builder(
            builder: (context) {
              final itemColorScheme = Theme.of(context).colorScheme;
              final isDelete = action == BeanCardAction.delete;
              final textColor = isDelete ? itemColorScheme.error : itemColorScheme.onSurface;
              final iconColor = isDelete ? itemColorScheme.error : itemColorScheme.onSurfaceVariant;

              return Row(
                children: [
                  Icon(
                    action.icon,
                    color: iconColor,
                    size: soco_metrics.icon.medium,
                  ),
                  soco_metrics.horizontalBox.small,
                  Text(
                    action.label,
                    style: TextStyle(color: textColor),
                  ),
                ],
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
