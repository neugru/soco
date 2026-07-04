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

class Coffee {
  final String id;
  final String name;
  final String brand;
  final double grindSize;
  final String origin;
  final RoastLevel roastLevel;
  final String description;
  final double rating;

  final String grinder;   // TODO link to Grinder entity
  final String machine;   // TODO link to Machine entity

  const Coffee({
    required this.id,
    required this.name,
    required this.brand,
    required this.grindSize,
    required this.origin,
    required this.roastLevel,
    required this.description,
    required this.rating,
    required this.grinder,
    required this.machine,
  });

  Coffee copyWith({
    String? id,
    String? name,
    String? brand,
    double? grindSize,
    String? origin,
    RoastLevel? roastLevel,
    String? description,
    double? rating,
    String? grinder,
    String? machine,
  }) {
    return Coffee(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      grindSize: grindSize ?? this.grindSize,
      origin: origin ?? this.origin,
      roastLevel: roastLevel ?? this.roastLevel,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      grinder: grinder ?? this.grinder,
      machine: machine ?? this.machine,
    );
  }
}
