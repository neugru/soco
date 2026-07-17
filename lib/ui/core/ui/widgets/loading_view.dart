import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/sizes.dart' as soco_sizes;

/// A shared widget that displays a centered loading indicator with an optional text message.
class LoadingView extends StatelessWidget {
  /// The text message to display below the progress indicator.
  /// Defaults to 'Loading...'.
  final String message;

  /// Vertical padding applied at the bottom of the container,
  /// typically used to avoid overlapping with bottom bars or floating buttons.
  /// Defaults to `0.0`.
  final double bottomPadding;

  const LoadingView({
    super.key,
    this.message = 'Loading...',
    this.bottomPadding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            soco_sizes.verticalBox.medium,
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
