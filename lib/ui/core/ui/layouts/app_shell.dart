import 'package:flutter/material.dart';

import 'package:soco/ui/features/bean_library/views/bean_library_view.dart';
import 'package:soco/ui/core/styles/soco_icons.dart';
import 'package:soco/ui/core/ui/widgets/outer_shadow.dart';
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

    final Widget bottomNavBar = SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.spacing.medium,
          vertical: AppSizes.spacing.medium,
        ),
        child: OuterShadow(
          shadows: AppElevation.shadows.mid,
          borderRadius: BorderRadius.circular(AppSizes.radius.round),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radius.round),
            child: NavigationBar(
              selectedIndex: _currentIndex,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              onDestinationSelected: (index) => setState(() => _currentIndex = index),
              destinations: destinations,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      extendBody: true,
      body: ShaderMask(
        shaderCallback: (Rect bounds) {
          final navBarHeight = NavigationBarTheme.of(context).height ?? 64.0;
          final bottomSpacing = AppSizes.spacing.medium * 2; // vertical padding is applied top and bottom
          final safeAreaBottom = MediaQuery.paddingOf(context).bottom;
          final navBarZoneHeight = navBarHeight + bottomSpacing + safeAreaBottom;

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
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: bottomNavBar,
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
