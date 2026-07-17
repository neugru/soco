import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/icons.dart';
import 'package:soco/ui/core/styles/sizes.dart' as soco_sizes;

/// A premium, contextual AppBar shown during multi-selection mode.
///
/// Displays the current selected count, a leading close/cancel button,
/// and a text button action to toggle between Select All and Deselect All.
class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The number of currently selected items.
  final int selectedCount;

  /// The total number of items available for selection.
  final int totalCount;

  /// Callback triggered when the clear/cancel action is tapped.
  final VoidCallback onClear;

  /// Callback triggered when the select all action is tapped.
  final VoidCallback onSelectAll;

  /// Callback triggered when the deselect all action is tapped.
  final VoidCallback onDeselectAll;

  /// Creates a [SelectionAppBar].
  const SelectionAppBar({
    super.key,
    required this.selectedCount,
    required this.totalCount,
    required this.onClear,
    required this.onSelectAll,
    required this.onDeselectAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAllSelected = selectedCount == totalCount && totalCount > 0;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(SocoIcons.clear, size: soco_sizes.icon.medium),
        onPressed: onClear,
      ),
      title: Text(
        '$selectedCount Selected',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: isAllSelected ? onDeselectAll : onSelectAll,
          child: Text(
            isAllSelected ? 'Deselect All' : 'Select All',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
