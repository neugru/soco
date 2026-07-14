import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/sizes.dart';

/// A custom AppBar for the library section.
class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title to display in the app bar.
  final String title;

  /// The icon to display in the app bar.
  final IconData icon;

  /// Optional actions to display in the app bar.
  final List<Widget>? actions;

  const LibraryAppBar({
    super.key,
    required this.title,
    required this.icon,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Row(
        children: [
          Icon(
            icon,
            size: SocoSizes.icon.large,
            color: colorScheme.primary,
          ),
          SocoSizes.gap.small,
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
