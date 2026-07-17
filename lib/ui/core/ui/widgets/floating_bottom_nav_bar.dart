import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/sizes.dart' as soco_sizes;
import 'package:soco/ui/core/styles/elevation.dart';
import 'package:soco/ui/core/ui/widgets/outer_shadow.dart';

/// A customized, floating bottom navigation bar wrapped in padding and shadows.
class FloatingBottomNavBar extends StatelessWidget {
  /// The index of the currently selected destination.
  final int selectedIndex;

  /// Callback triggered when a destination is tapped.
  final ValueChanged<int> onDestinationSelected;

  /// The list of navigation destinations to display.
  final List<NavigationDestination> destinations;

  /// The spacing/padding applied around the floating bar.
  /// Defaults to `EdgeInsets.all(soco_sizes.spacing.medium)`.
  final EdgeInsetsGeometry? padding;

  const FloatingBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: padding ?? EdgeInsets.all(soco_sizes.spacing.medium),
        child: OuterShadow(
          shadows: SocoElevation.shadows.mid,
          borderRadius: BorderRadius.circular(soco_sizes.radius.round),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(soco_sizes.radius.round),
            child: NavigationBar(
              selectedIndex: selectedIndex,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              onDestinationSelected: onDestinationSelected,
              destinations: destinations,
            ),
          ),
        ),
      ),
    );
  }
}
