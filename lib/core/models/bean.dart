import 'package:uuid/uuid.dart';
import 'roast_level.dart';

class Bean {
  final String id;
  final String name;
  final String brand;
  final String origin;
  final RoastLevel roastLevel;

  const Bean({
    required this.id,
    required this.name,
    required this.brand,
    required this.origin,
    required this.roastLevel,
  });

  factory Bean.create({
    required String name,
    required String brand,
    required String origin,
    required RoastLevel roastLevel,
  }) {
    return Bean(
      id: const Uuid().v4(),
      name: name,
      brand: brand,
      origin: origin,
      roastLevel: roastLevel,
    );
  }

  Bean copyWith({
    String? id,
    String? name,
    String? brand,
    String? origin,
    RoastLevel? roastLevel,
  }) {
    return Bean(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      origin: origin ?? this.origin,
      roastLevel: roastLevel ?? this.roastLevel,
    );
  }
}
