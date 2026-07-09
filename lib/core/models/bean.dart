import 'package:uuid/uuid.dart';

import 'package:soco/core/models/roast_level.dart';

class Bean {
  final String id;
  final String name;
  final String brand;
  final int strength;
  final String? origin;
  final RoastLevel? roastLevel;

  const Bean({
    required this.id,
    required this.name,
    required this.brand,
    required this.strength,
    this.origin,
    this.roastLevel,
  });

  factory Bean.create({
    required String name,
    required String brand,
    required int strength,
    String? origin,
    RoastLevel? roastLevel,
  }) {
    return Bean(
      id: const Uuid().v4(),
      name: name,
      brand: brand,
      strength: strength,
      origin: origin,
      roastLevel: roastLevel,
    );
  }

  Bean copyWith({
    String? id,
    String? name,
    String? brand,
    int? strength,
    String? origin,
    RoastLevel? roastLevel,
  }) {
    return Bean(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      strength: strength ?? this.strength,
      origin: origin ?? this.origin,
      roastLevel: roastLevel ?? this.roastLevel,
    );
  }
}
