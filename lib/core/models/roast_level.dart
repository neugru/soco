enum RoastLevel {
  light,
  medium,
  dark;

  String get displayName {
    switch (this) {
      case RoastLevel.light:
        return 'Light';
      case RoastLevel.medium:
        return 'Medium';
      case RoastLevel.dark:
        return 'Dark';
    }
  }
}
