import 'package:flutter/material.dart';

import 'package:soco/ui/features/bean_library/views/bean_library_view.dart';
import 'package:soco/ui/core/styles/icons.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/ui/widgets/floating_bottom_nav_bar.dart';

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
  int _currentIndex = 1;  // TODO: change to 0 after testing

  @override
  Widget build(BuildContext context) {
    final bottomNavBarPadding = SocoSizes.spacing.medium;

    return Scaffold(
      extendBody: true,
      body: _BottomFadeMask(
        bottomNavBarPadding: bottomNavBarPadding * 2,
        child: IndexedStack(
          index: _currentIndex,
          children: AppTab.values.map((tab) => tab.page).toList(),
        ),
      ),
      bottomNavigationBar: FloatingBottomNavBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: AppTab.values.map((tab) => tab.destination).toList(),
        padding: EdgeInsets.all(bottomNavBarPadding),
      ),
    );
  }
}

/// The set of primary tabs available in the main app shell.
enum AppTab {
  home(
    icon: SocoIcons.home,
    label: 'Home',
  ),
  beans(
    icon: SocoIcons.coffeeBean,
    label: 'Beans',
  ),
  machines(
    icon: SocoIcons.coffeeMaker,
    label: 'Machines',
  ),
  profile(
    icon: SocoIcons.person,
    label: 'Profile',
  );

  final IconData icon;
  final String label;

  const AppTab({
    required this.icon,
    required this.label,
  });

  /// Instantiates the page widget corresponding to this tab.
  Widget get page {
    switch (this) {
      case AppTab.home:
        return const _PlaceholderPage(label: 'Group Library');
      case AppTab.beans:
        return const BeanLibraryView();
      case AppTab.machines:
        return const _PlaceholderPage(label: 'Machine Library');
      case AppTab.profile:
        return const _PlaceholderPage(label: 'Profile Page');
    }
  }

  /// Generates the navigation destination bar item.
  NavigationDestination get destination => NavigationDestination(
    icon: Icon(icon),
    label: label,
  );
}

// TODO: delete placeholder page
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

class _BottomFadeMask extends StatelessWidget {
  final Widget child;

  /// The total vertical padding (top + bottom) applied to the bottomNavBar.
  final double bottomNavBarPadding;

  const _BottomFadeMask({
    required this.child,
    required this.bottomNavBarPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        final safeAreaBottom = MediaQuery.paddingOf(context).bottom;

        // Convert absolute pixels to a relative stop value (0.0 to 1.0)
        final fadeStart = (bounds.height - (safeAreaBottom * 1.5)).clamp(0.0, bounds.height) / bounds.height;
        final fadeEnd = (bounds.height - (safeAreaBottom * 0.05)).clamp(0.0, bounds.height) / bounds.height;

        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black,
            Colors.transparent,
            Colors.transparent,
          ],
          stops: [0, fadeStart, fadeEnd, 1],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
