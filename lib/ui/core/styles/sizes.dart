import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

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

  final SizedBox extraSmall = const SizedBox(width: 4.0, height: 4.0);
  final SizedBox small = const SizedBox(width: 8.0, height: 8.0);
  final SizedBox medium = const SizedBox(width: 16.0, height: 16.0);
  final SizedBox large = const SizedBox(width: 24.0, height: 24.0);
  final SizedBox extraLarge = const SizedBox(width: 32.0, height: 32.0);
  final SizedBox extraLarge2 = const SizedBox(width: 48.0, height: 48.0);
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
