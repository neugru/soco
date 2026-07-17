import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:soco/ui/core/styles/assets.dart';
import 'package:soco/ui/core/styles/sizes.dart' as soco_sizes;
import 'package:soco/ui/core/styles/icons.dart';

class EmptyLibraryView extends StatelessWidget {
  /// The text message to display when the library is empty.
  final String message;

  /// The text message to display when a search yields no results.
  final String searchMessage;

  /// An SVG vector asset to display as the main illustration of the default empty state.
  ///
  /// Takes priority over [icon] if both are provided.
  final SvgAsset? asset;

  /// An icon to display as the main illustration of the default empty state
  /// if no [asset] is provided.
  final IconData? icon;

  /// The icon to display when a search yields no results.
  /// Defaults to `SocoIcons.searchOff`.
  final IconData searchIcon;

  /// The active search query string. If this is non-null and not empty,
  /// the view renders a search-specific empty state instead of the default message.
  final String? searchQuery;

  /// Vertical padding applied at the bottom of the scroll view,
  /// typically used to avoid overlapping with bottom bars or floating buttons.
  /// Defaults to `0.0`.
  final double bottomPadding;

  /// A shared widget that displays a consistent empty state for libraries.
  ///
  /// It supports two visual modes:
  /// 1. **Default Empty State**: Shown when there is no active search. Displays
  ///    an illustration (prioritizes an SVG [asset], falls back to an [icon]) and a custom [message].
  /// 2. **Search Empty State**: Shown when [searchQuery] is non-empty. Displays
  ///    a custom message [searchMessage] and icon [searchIcon].
  const EmptyLibraryView({
    super.key,
    required this.message,
    required this.searchMessage,
    this.asset,
    this.icon,
    this.searchIcon = SocoIcons.searchOff,
    this.searchQuery,
    this.bottomPadding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget buildContent() {
      final query = searchQuery;
      if (query != null && query.trim().isNotEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              searchIcon,
              size: soco_sizes.icon.xxLarge,
              color: colorScheme.outline.withValues(alpha: 0.5),
            ),
            soco_sizes.verticalBox.medium,
            Text(
              searchMessage,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }

      const iconSize = 220.0;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (asset != null)
            SvgPicture.asset(
              asset!.path,
              width: iconSize,
              height: iconSize,
              colorFilter: ColorFilter.mode(
                colorScheme.outline,
                BlendMode.srcIn,
              ),
            )
          else if (icon != null)
            Icon(
              icon,
              size: iconSize,
              color: colorScheme.outline,
            ),
          soco_sizes.verticalBox.small,
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: (constraints.maxHeight - bottomPadding).clamp(0.0, double.infinity),
            ),
            child: Center(
              child: buildContent(),
            ),
          ),
        );
      },
    );
  }
}
