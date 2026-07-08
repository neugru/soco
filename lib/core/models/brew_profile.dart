import 'package:uuid/uuid.dart';

import 'package:soco/core/models/bean.dart';
import 'package:soco/core/models/grinder.dart';
import 'package:soco/core/models/machine.dart';

class BrewProfile {
  final String id;
  final Bean bean;
  final Machine machine;
  final Grinder grinder;
  final double dose;
  final double grindSize;
  final double brewYield;
  final int brewTimeSeconds;
  final String description;
  final double rating;

  const BrewProfile({
    required this.id,
    required this.bean,
    required this.machine,
    required this.grinder,
    required this.dose,
    required this.grindSize,
    required this.brewYield,
    required this.brewTimeSeconds,
    required this.description,
    required this.rating,
  });

  factory BrewProfile.create({
    required Bean bean,
    required Machine machine,
    required Grinder grinder,
    required double dose,
    required double grindSize,
    required double brewYield,
    required int brewTimeSeconds,
    required String description,
    required double rating,
  }) {
    return BrewProfile(
      id: const Uuid().v4(),
      bean: bean,
      machine: machine,
      grinder: grinder,
      dose: dose,
      grindSize: grindSize,
      brewYield: brewYield,
      brewTimeSeconds: brewTimeSeconds,
      description: description,
      rating: rating,
    );
  }

  BrewProfile copyWith({
    String? id,
    Bean? bean,
    Machine? machine,
    Grinder? grinder,
    double? dose,
    double? grindSize,
    double? brewYield,
    int? brewTimeSeconds,
    String? description,
    double? rating,
  }) {
    return BrewProfile(
      id: id ?? this.id,
      bean: bean ?? this.bean,
      machine: machine ?? this.machine,
      grinder: grinder ?? this.grinder,
      dose: dose ?? this.dose,
      grindSize: grindSize ?? this.grindSize,
      brewYield: brewYield ?? this.brewYield,
      brewTimeSeconds: brewTimeSeconds ?? this.brewTimeSeconds,
      description: description ?? this.description,
      rating: rating ?? this.rating,
    );
  }
}
