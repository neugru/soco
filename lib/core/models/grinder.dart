import 'package:uuid/uuid.dart';

class Grinder {
  final String id;
  final String brand;
  final String name;

  const Grinder({
    required this.id,
    required this.brand,
    required this.name,
  });

  factory Grinder.create({
    required String brand,
    required String name,
  }) {
    return Grinder(
      id: const Uuid().v4(),
      brand: brand,
      name: name,
    );
  }

  String get displayName => brand.isEmpty ? name : '$brand $name';
}
