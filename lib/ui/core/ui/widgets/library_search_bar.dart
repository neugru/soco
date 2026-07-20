import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/elevation.dart';
import 'package:soco/ui/core/styles/metrics.dart' as soco_metrics;
import 'package:soco/ui/core/styles/icons.dart';

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
        borderRadius: BorderRadius.circular(soco_metrics.radius.large),
        boxShadow: SocoElevation.shadows.low,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide.none,
          //   borderRadius: BorderRadius.circular(soco_metrics.radius.medium),
          // ),
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
                        size: soco_metrics.icon.small,
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
