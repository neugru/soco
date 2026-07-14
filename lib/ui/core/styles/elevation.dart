import 'package:flutter/material.dart';

/// Centralized Elevation and Shadow Tokens.
///
/// Contains both raw elevation values (for material widgets like [Card])
/// and custom [BoxShadow] designs (for custom containers).
class SocoElevation {
  SocoElevation._();

  // Raw elevation doubles
  static const double none = 0.0;
  static const double low = 1.0;
  static const double mid = 3.0;
  static const double high = 6.0;

  // Custom shadows for container decoration
  static const shadows = _ElevationShadows();
}

class _ElevationShadows {
  const _ElevationShadows();

  /// Subtle elevation shadow suitable for cards and small components
  List<BoxShadow> get low => [
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.15),
      blurRadius: 4,
      offset: const Offset(0, 3),
    ),
  ];

  /// Medium elevation shadow suitable for floating elements or dialogs
  List<BoxShadow> get mid => [
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.15),
      blurRadius: 6,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.25),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  /// High elevation shadow suitable for bottom sheets or overlays
  List<BoxShadow> get high => [
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.12),
      blurRadius: 8,
      offset: const Offset(0, 6),
    ),
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.25),
      blurRadius: 6,
      offset: const Offset(0, 4),
    ),
  ];
}
