import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/sizes.dart';

/// A full-width, translucent bottom navigation bar styled similarly to Spotify.
///
/// Blurs and fades the background content behind it to maintain visibility
/// and high contrast for navigation items.
class BottomNavBar extends StatelessWidget {
  /// The index of the currently selected destination.
  final int selectedIndex;

  /// Callback triggered when a destination is tapped.
  final ValueChanged<int> onDestinationSelected;

  /// The list of navigation destinations to display.
  final List<NavigationDestination> destinations;

  /// Creates a [BottomNavBar].
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final surfaceColor = colorScheme.surface;

    return Container(
      padding: EdgeInsets.only(top: SocoSizes.spacing.large),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            surfaceColor.withValues(alpha: 0),
            surfaceColor.withValues(alpha: 0.85),
            surfaceColor,
          ],
          stops: const [0, 0.3, 0.98],
        ),
      ),
      child: SafeArea(
        top: false,
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIndex: selectedIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: onDestinationSelected,
          destinations: destinations,
        ),
      ),
    );
  }
}
