import 'package:uuid/uuid.dart';

import 'package:soco/core/models/bean.dart';
import 'package:soco/core/models/grinder.dart';
import 'package:soco/core/models/machine.dart';

class BrewProfile {
  final String id;
  final Bean bean;
  final double dose;
  final double grindSize;
  final double brewYield;
  final int brewTimeSeconds;
  final Machine machine;
  final Grinder? grinder;
  final String? description;

  const BrewProfile({
    required this.id,
    required this.bean,
    required this.dose,
    required this.grindSize,
    required this.brewYield,
    required this.brewTimeSeconds,
    required this.machine,
    this.grinder,
    this.description,
  });

  factory BrewProfile.create({
    required Bean bean,
    required double dose,
    required double grindSize,
    required double brewYield,
    required int brewTimeSeconds,
    required Machine machine,
    Grinder? grinder,
    String? description,
  }) {
    return BrewProfile(
      id: const Uuid().v4(),
      bean: bean,
      dose: dose,
      grindSize: grindSize,
      brewYield: brewYield,
      brewTimeSeconds: brewTimeSeconds,
      machine: machine,
      grinder: grinder,
      description: description,
    );
  }

  BrewProfile copyWith({
    String? id,
    Bean? bean,
    double? dose,
    double? grindSize,
    double? brewYield,
    int? brewTimeSeconds,
    Machine? machine,
    Grinder? grinder,
    String? description,
  }) {
    return BrewProfile(
      id: id ?? this.id,
      bean: bean ?? this.bean,
      dose: dose ?? this.dose,
      grindSize: grindSize ?? this.grindSize,
      brewYield: brewYield ?? this.brewYield,
      brewTimeSeconds: brewTimeSeconds ?? this.brewTimeSeconds,
      machine: machine ?? this.machine,
      grinder: grinder ?? this.grinder,
      description: description ?? this.description,
    );
  }
}
