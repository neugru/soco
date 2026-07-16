import 'package:flutter/material.dart';

// --- Private constants for Gap classes ---
const _gapExtraSmall = 4.0;
const _gapSmall = 8.0;
const _gapMedium = 16.0;
const _gapLarge = 24.0;
const _gapExtraLarge = 32.0;
const _gapExtraLarge2 = 48.0;

class SocoSizes {
  SocoSizes._();

  static const radius = _Radius();
  static const spacing = _Spacing();
  static const button = _Button();
  static const input = _Input();
  static const gap = _Gap();
  static const icon = _Icon();
}

class _Radius {
  const _Radius();

  final double small = 8.0;
  final double medium = 12.0;
  final double large = 16.0;
  final double extraLarge = 24.0;
  final double round = 999.0;
}

class _Spacing {
  const _Spacing();

  final double extraSmall = 4.0;
  final double small = 8.0;
  final double medium = 16.0;
  final double large = 24.0;
  final double extraLarge = 32.0;
  final double extraLarge2 = 48.0;
}

class _Button {
  const _Button();

  final double height = 40.0;
  final double heightSmall = 32.0;
}

class _Input {
  const _Input();

  final double paddingVertical = 18.0;
  final double paddingHorizontal = 16.0;
}

class _Gap {
  const _Gap();

  final SizedBox extraSmall = const SizedBox(width: _gapExtraSmall, height: _gapExtraSmall);
  final SizedBox small = const SizedBox(width: _gapSmall, height: _gapSmall);
  final SizedBox medium = const SizedBox(width: _gapMedium, height: _gapMedium);
  final SizedBox large = const SizedBox(width: _gapLarge, height: _gapLarge);
  final SizedBox extraLarge = const SizedBox(width: _gapExtraLarge, height: _gapExtraLarge);
  final SizedBox extraLarge2 = const SizedBox(width: _gapExtraLarge2, height: _gapExtraLarge2);

  final _VerticalGap vertical = const _VerticalGap();
  final _HorizontalGap horizontal = const _HorizontalGap();
}

class _VerticalGap {
  const _VerticalGap();

  final SizedBox extraSmall = const SizedBox(height: _gapExtraSmall);
  final SizedBox small = const SizedBox(height: _gapSmall);
  final SizedBox medium = const SizedBox(height: _gapMedium);
  final SizedBox large = const SizedBox(height: _gapLarge);
  final SizedBox extraLarge = const SizedBox(height: _gapExtraLarge);
  final SizedBox extraLarge2 = const SizedBox(height: _gapExtraLarge2);
}

class _HorizontalGap {
  const _HorizontalGap();

  final SizedBox extraSmall = const SizedBox(width: _gapExtraSmall);
  final SizedBox small = const SizedBox(width: _gapSmall);
  final SizedBox medium = const SizedBox(width: _gapMedium);
  final SizedBox large = const SizedBox(width: _gapLarge);
  final SizedBox extraLarge = const SizedBox(width: _gapExtraLarge);
  final SizedBox extraLarge2 = const SizedBox(width: _gapExtraLarge2);
}

class _Icon {
  const _Icon();

  final double extraSmall = 14.0;
  final double small = 16.0;
  final double medium = 20.0;
  final double large = 24.0;
  final double extraLarge = 32.0;
  final double extraLarge2 = 64.0;
}
