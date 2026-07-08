import 'package:uuid/uuid.dart';

import 'package:soco/core/models/roast_level.dart';

class Bean {
  final String id;
  final String name;
  final String brand;
  final String origin;
  final RoastLevel roastLevel;
  final int strength;

  const Bean({
    required this.id,
    required this.name,
    required this.brand,
    required this.origin,
    required this.roastLevel,
    required this.strength,
  });

  factory Bean.create({
    required String name,
    required String brand,
    required String origin,
    required RoastLevel roastLevel,
    required int strength,
  }) {
    return Bean(
      id: const Uuid().v4(),
      name: name,
      brand: brand,
      origin: origin,
      roastLevel: roastLevel,
      strength: strength,
    );
  }

  Bean copyWith({
    String? id,
    String? name,
    String? brand,
    String? origin,
    RoastLevel? roastLevel,
    int? strength,
  }) {
    return Bean(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      origin: origin ?? this.origin,
      roastLevel: roastLevel ?? this.roastLevel,
      strength: strength ?? this.strength,
    );
  }
}
