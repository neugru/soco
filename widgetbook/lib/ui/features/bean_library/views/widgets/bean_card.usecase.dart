import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:soco/core/models/bean.dart';
import 'package:soco/core/models/brew_profile.dart';
import 'package:soco/core/models/grinder.dart';
import 'package:soco/core/models/machine.dart';
import 'package:soco/core/models/roast_level.dart';
import 'package:soco/ui/features/bean_library/views/widgets/bean_card.dart';



@widgetbook.UseCase(name: 'Default', type: BeanCard)
Widget buildBeanCardUseCase(BuildContext context) {

  final isCompact = context.knobs.boolean(
    label: 'Is Compact',
    initialValue: false,
  );

  final profile = BrewProfile.create(
    bean: Bean.create(
      name: context.knobs.string(label: 'Bean Name', initialValue: 'Espresso Roma'),
      brand: context.knobs.string(label: 'Brand', initialValue: 'Ettli'),
      origin: context.knobs.string(label: 'Origin', initialValue: 'South-/Central-America'),
      strength: context.knobs.int.slider(
        label: 'Strength',
        initialValue: 2,
        min: 1,
        max: 5,
      ),
      roastLevel: context.knobs.object.dropdown<RoastLevel?>(
        label: 'Roast Level',
        initialOption: RoastLevel.medium,
        options: [null, ...RoastLevel.values],
        labelBuilder: (level) => level?.displayName ?? 'Not Specified',
      ),
    ),
    dose: context.knobs.double.slider(
      label: 'Dose (g)',
      initialValue: 18.0,
      min: 5.0,
      max: 30.0,
    ),
    grindSize: context.knobs.double.slider(
      label: 'Grind Size',
      initialValue: 4.4,
      min: 1.0,
      max: 20.0,
    ),
    brewYield: context.knobs.double.slider(
      label: 'Yield (g)',
      initialValue: 42.0,
      min: 5.0,
      max: 100.0,
    ),
    brewTimeSeconds: context.knobs.int.slider(
      label: 'Brew Time (s)',
      initialValue: 28,
      min: 5,
      max: 120,
    ),
    machine: Machine.create(
      brand: context.knobs.string(label: 'Machine Brand', initialValue: 'Gaggia'),
      name: context.knobs.string(label: 'Machine Model', initialValue: 'Classic Evo Pro 2023'),
    ),
    grinder: context.knobs.boolean(label: 'Has Grinder', initialValue: true)
        ? Grinder.create(
            brand: context.knobs.string(label: 'Grinder Brand', initialValue: 'Varia'),
            name: context.knobs.string(label: 'Grinder Model', initialValue: 'VS3'),
          )
        : null,
    description: context.knobs.string(
      label: 'Description',
      initialValue: 'Soft, round aroma, mild',
    ),
  );

  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BeanCard(
          profile: profile,
          isCompact: isCompact,
        ),
      ),
    ),
  );
}
