import 'package:uuid/uuid.dart';

class Machine {
  final String id;
  final String brand;
  final String name;

  const Machine({
    required this.id,
    required this.brand,
    required this.name,
  });

  factory Machine.create({
    required String brand,
    required String name,
  }) {
    return Machine(
      id: const Uuid().v4(),
      brand: brand,
      name: name,
    );
  }

  String get displayName => brand.isEmpty ? name : '$brand $name';
}
