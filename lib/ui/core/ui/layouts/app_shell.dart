import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soco/ui/features/coffee_library/views/coffee_library_view.dart';

import 'package:soco/utils/constants/assets.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/elevation.dart';

/// The main scaffold of the app. Wraps each top-level screen with
/// a shared [BottomNavigationBar].
///
/// Add / remove [_destinations] to control what tabs appear.
/// Swap [_pages] to change which screen each tab renders.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  // ── Pages ─────────────────────────────────────────────────────────────────
  // Replace placeholders with your real screen widgets as you build them.
  static const List<Widget> _pages = [
    CoffeeLibraryView(),
    _PlaceholderPage(label: 'Bean Library'),
    _PlaceholderPage(label: 'Machine Library'),
    _PlaceholderPage(label: 'Profile Page'),
  ];

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final iconColor = IconTheme.of(context).color ?? Colors.black;

    final destinations = [
      NavigationDestination(
        icon: SvgPicture.asset(
          AppAssets.icons.home,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
        label: 'Home',
      ),
      NavigationDestination(
        icon: SvgPicture.asset(
          AppAssets.icons.coffeeBean,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
        label: 'Beans',
      ),
      NavigationDestination(
        icon: SvgPicture.asset(
          AppAssets.icons.coffeeMaker,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
        label: 'Machines',
      ),
      NavigationDestination(
        icon: SvgPicture.asset(
          AppAssets.icons.person,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
        label: 'Profile',
      ),
    ];

    // TODO check NavBar design
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: soco_sizes.AppSizes.spacing.medium,
            vertical: soco_sizes.AppSizes.spacing.medium,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.round),
              boxShadow: AppElevation.shadows.mid,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(soco_sizes.AppSizes.radius.round),
              child: NavigationBar(
                selectedIndex: _currentIndex,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                onDestinationSelected: (index) => setState(() => _currentIndex = index),
                destinations: destinations,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Temporary placeholder ──────────────────────────────────────────────────
// Delete this once you have real screen widgets.
class _PlaceholderPage extends StatelessWidget {
  final String label;
  const _PlaceholderPage({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label, style: Theme.of(context).textTheme.displaySmall),
    );
  }
}
