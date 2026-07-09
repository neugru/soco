import 'package:uuid/uuid.dart';

import 'package:soco/core/models/roast_level.dart';

class Bean {
  final String id;
  final String name;
  final String brand;
  final String origin;
  final int strength;
  final RoastLevel? roastLevel;

  const Bean({
    required this.id,
    required this.name,
    required this.brand,
    required this.origin,
    required this.strength,
    this.roastLevel,
  });

  factory Bean.create({
    required String name,
    required String brand,
    required String origin,
    required int strength,
    RoastLevel? roastLevel,
  }) {
    return Bean(
      id: const Uuid().v4(),
      name: name,
      brand: brand,
      origin: origin,
      strength: strength,
      roastLevel: roastLevel,
    );
  }

  Bean copyWith({
    String? id,
    String? name,
    String? brand,
    String? origin,
    int? strength,
    RoastLevel? roastLevel,
  }) {
    return Bean(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      origin: origin ?? this.origin,
      strength: strength ?? this.strength,
      roastLevel: roastLevel ?? this.roastLevel,
    );
  }
}
