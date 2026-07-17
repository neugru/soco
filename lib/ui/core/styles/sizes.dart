// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class radius {
  radius._();

  static const double small = 8.0;
  static const double medium = 12.0;
  static const double large = 16.0;
  static const double xLarge = 24.0;
  static const double round = 999.0;
}

class spacing {
  spacing._();

  static const double xSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double xLarge = 32.0;
  static const double xxLarge = 48.0;
}

class button {
  button._();

  static const double height = 40.0;
  static const double heightSmall = 32.0;
}

class input {
  input._();

  static const double paddingVertical = 18.0;
  static const double paddingHorizontal = 16.0;
}

class _box_sizes {
  _box_sizes._();

  static const double xSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double xLarge = 32.0;
  static const double xxLarge = 48.0;
}

class verticalBox {
  verticalBox._();

  static const SizedBox xSmall = SizedBox(height: _box_sizes.xSmall);
  static const SizedBox small = SizedBox(height: _box_sizes.small);
  static const SizedBox medium = SizedBox(height: _box_sizes.medium);
  static const SizedBox large = SizedBox(height: _box_sizes.large);
  static const SizedBox xLarge = SizedBox(height: _box_sizes.xLarge);
  static const SizedBox xxLarge = SizedBox(height: _box_sizes.xxLarge);
}

class horizontalBox {
  horizontalBox._();

  static const SizedBox xSmall = SizedBox(width: _box_sizes.xSmall);
  static const SizedBox small = SizedBox(width: _box_sizes.small);
  static const SizedBox medium = SizedBox(width: _box_sizes.medium);
  static const SizedBox large = SizedBox(width: _box_sizes.large);
  static const SizedBox xLarge = SizedBox(width: _box_sizes.xLarge);
  static const SizedBox xxLarge = SizedBox(width: _box_sizes.xxLarge);
}

class icon {
  icon._();

  static const double xSmall = 14.0;
  static const double small = 16.0;
  static const double medium = 20.0;
  static const double large = 24.0;
  static const double xLarge = 32.0;
  static const double xxLarge = 64.0;
}
