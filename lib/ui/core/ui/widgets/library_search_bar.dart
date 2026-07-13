import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/elevation.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/soco_icons.dart';

class LibrarySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  final VoidCallback? onClear;

  const LibrarySearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search...',
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSizes.radius.large),
        boxShadow: AppElevation.shadows.low,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            SocoIcons.search,
            color: colorScheme.outline,
          ),
          suffixIcon: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        SocoIcons.clear,
                        size: AppSizes.icon.small,
                      ),
                      onPressed: onClear,
                    )
                  : const SizedBox.shrink();
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
