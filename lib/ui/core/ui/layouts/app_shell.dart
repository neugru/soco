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
  int _currentIndex = 1;

  // ── Pages ─────────────────────────────────────────────────────────────────
  // Replace placeholders with your real screen widgets as you build them.
  static const List<Widget> _pages = [
    _PlaceholderPage(label: 'Group Libray'),
    BeanLibraryView(),
    _PlaceholderPage(label: 'Machine Library'),
    _PlaceholderPage(label: 'Profile Page'),
  ];

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    const destinations = [
      NavigationDestination(
        icon: Icon(SocoIcons.home),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(SocoIcons.coffeeBean),
        label: 'Beans',
      ),
      NavigationDestination(
        icon: Icon(SocoIcons.coffeeMaker),
        label: 'Machines',
      ),
      NavigationDestination(
        icon: Icon(SocoIcons.person),
        label: 'Profile',
      ),
    ];

    final bottomNavBarPadding = SocoSizes.spacing.medium;

    return Scaffold(
      extendBody: true,
      body: _BottomFadeMask(
        bottomNavBarPadding: bottomNavBarPadding * 2,
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: FloatingBottomNavBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: destinations,
        padding: EdgeInsets.all(bottomNavBarPadding),
      ),
    );
  }
}

// TODO: delete placeholder
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
        final navBarHeight = NavigationBarTheme.of(context).height ?? 0;
        final safeAreaBottom = MediaQuery.paddingOf(context).bottom;
        final navBarZoneHeight = navBarHeight + bottomNavBarPadding + safeAreaBottom;

        // Convert absolute pixels to a relative stop value (0.0 to 1.0)
        final fadeStart = (bounds.height - navBarZoneHeight).clamp(0.0, bounds.height) / bounds.height;
        final fadeEnd = (bounds.height - (safeAreaBottom * 0.5)).clamp(0.0, bounds.height) / bounds.height;

        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [
            Colors.black,
            Colors.transparent,
          ],
          stops: [fadeStart, fadeEnd],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
