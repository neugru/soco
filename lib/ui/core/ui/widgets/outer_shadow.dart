import 'package:flutter/material.dart';

class OuterShadow extends StatelessWidget {
  final List<BoxShadow> shadows;
  final BorderRadius borderRadius;
  final Widget child;

  const OuterShadow({
    super.key,
    required this.shadows,
    required this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _OuterShadowPainter(
        shadows: shadows,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class _OuterShadowPainter extends CustomPainter {
  final List<BoxShadow> shadows;
  final BorderRadius borderRadius;

  _OuterShadowPainter({
    required this.shadows,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = borderRadius.toRRect(rect);
    final innerPath = Path()..addRRect(rrect);

    // Create a path that covers the entire canvas bounds (inflated to allow shadow spreads to render)
    final outerPath = Path()..addRect(rect.inflate(100.0));

    // Combine paths to get a path that is ONLY outside the rounded capsule
    final combinedPath = Path.combine(PathOperation.difference, outerPath, innerPath);

    canvas.save();
    // Clip the canvas to our outer-only path
    canvas.clipPath(combinedPath);

    for (final shadow in shadows) {
      final paint = shadow.toPaint();
      final shadowRRect = rrect.shift(shadow.offset).inflate(shadow.spreadRadius);
      canvas.drawRRect(shadowRRect, paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _OuterShadowPainter oldDelegate) {
    return oldDelegate.shadows != shadows || oldDelegate.borderRadius != borderRadius;
  }
}
