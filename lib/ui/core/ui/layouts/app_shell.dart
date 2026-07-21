import 'package:flutter/material.dart';

import 'package:soco/ui/features/bean_library/views/bean_library_view.dart';
import 'package:soco/ui/core/styles/icons.dart';
import 'package:soco/ui/core/ui/widgets/bottom_nav_bar.dart';

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
  int _currentIndex = 1; // TODO: change to 0 after testing
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: AppTab.values.map((tab) => tab.page).toList(),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          final isAdjacent = (index - _currentIndex).abs() == 1;

          setState(() {
            _currentIndex = index;
          });

          if (isAdjacent) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            _pageController.jumpToPage(index);
          }

        },
        destinations: AppTab.values.map((tab) => tab.destination).toList(),
      ),
    );
  }
}

/// The set of primary tabs available in the main app shell.
enum AppTab {
  home(
    icon: SocoIcons.homeOutlined,
    selectedIcon: SocoIcons.home,
    label: 'Home',
  ),
  beans(
    icon: SocoIcons.coffeeBeanOutlined,
    selectedIcon: SocoIcons.coffeeBean,
    label: 'Beans',
  ),
  machines(
    icon: SocoIcons.coffeeMakerOutlined,
    selectedIcon: SocoIcons.coffeeMaker,
    label: 'Machines',
  ),
  profile(
    icon: SocoIcons.personOutline,
    selectedIcon: SocoIcons.person,
    label: 'Profile',
  );

  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const AppTab({
    required this.icon,
    required this.selectedIcon,
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
    selectedIcon: Icon(selectedIcon),
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
