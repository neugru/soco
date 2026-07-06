import 'package:uuid/uuid.dart';

import 'package:soco/core/models/bean.dart';
import 'package:soco/core/models/grinder.dart';
import 'package:soco/core/models/machine.dart';

class BrewProfile {
  final String id;
  final Bean bean;
  final double grindSize;
  final String description;
  final double rating;
  final int strength;
  final Grinder grinder;
  final Machine machine;

  const BrewProfile({
    required this.id,
    required this.bean,
    required this.grindSize,
    required this.description,
    required this.rating,
    required this.strength,
    required this.grinder,
    required this.machine,
  });

  factory BrewProfile.create({
    required Bean bean,
    required double grindSize,
    required String description,
    required double rating,
    required int strength,
    required Grinder grinder,
    required Machine machine,
  }) {
    return BrewProfile(
      id: const Uuid().v4(),
      bean: bean,
      grindSize: grindSize,
      description: description,
      rating: rating,
      strength: strength,
      grinder: grinder,
      machine: machine,
    );
  }

  BrewProfile copyWith({
    String? id,
    Bean? bean,
    double? grindSize,
    String? description,
    double? rating,
    int? strength,
    Grinder? grinder,
    Machine? machine,
  }) {
    return BrewProfile(
      id: id ?? this.id,
      bean: bean ?? this.bean,
      grindSize: grindSize ?? this.grindSize,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      strength: strength ?? this.strength,
      grinder: grinder ?? this.grinder,
      machine: machine ?? this.machine,
    );
  }
}
