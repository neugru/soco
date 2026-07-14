import 'package:flutter/material.dart';


/// A widget that applies a smooth transparency fade to its child scrollable's edges.
class FadingMask extends StatelessWidget {
  /// The scrollable child to be masked.
  final Widget child;

  /// The height of the top fade area. If null, no top fade is applied.
  final double? fadeHeightTop;

  /// The height of the bottom fade area. If null, no bottom fade is applied.
  final double? fadeHeightBottom;

  const FadingMask({
    super.key,
    required this.child,
    this.fadeHeightTop,
    this.fadeHeightBottom,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        if (bounds.height == 0) {
          return const LinearGradient(colors: []).createShader(bounds);
        }

        final colors = <Color>[];
        final stops = <double>[];

        // Top fade segment
        final topHeight = fadeHeightTop;
        if (topHeight != null && topHeight > 0) {
          // percentage of screen height to end top fade
          final topEnd = (topHeight / bounds.height).clamp(0.0, 1.0);

          // start transparent
          colors.add(Colors.transparent);
          stops.add(0.0);

          // become opaque at topEnd
          colors.add(Colors.black);
          stops.add(topEnd);
        } else {
          // no fade, start opaque
          colors.add(Colors.black);
          stops.add(0.0);
        }

        // Bottom fade segment
        final bottomHeight = fadeHeightBottom;
        if (bottomHeight != null && bottomHeight > 0) {
          // percentage of screen height to start bottom fade
          final bottomStart = (1.0 - bottomHeight / bounds.height).clamp(0.0, 1.0);
          
          // start opaque at bottomStart
          colors.add(Colors.black);
          stops.add(bottomStart);

          // end transparent
          colors.add(Colors.transparent);
          stops.add(1.0);
        } else {
          // no fade, end opaque
          colors.add(Colors.black);
          stops.add(1.0);
        }

        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
          stops: stops,
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
