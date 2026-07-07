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
  final roast = context.knobs.object.dropdown<RoastLevel>(
    label: 'Roast Level',
    initialOption: RoastLevel.medium,
    options: RoastLevel.values,
    labelBuilder: (level) => level.displayName,
  );

  final profile = BrewProfile.create(
    bean: Bean.create(
      name: context.knobs.string(label: 'Bean Name', initialValue: 'Espresso Roma'),
      brand: context.knobs.string(label: 'Brand', initialValue: 'Ettli'),
      origin: context.knobs.string(label: 'Origin', initialValue: 'South-/Central-America'),
      roastLevel: roast,
    ),
    grindSize: context.knobs.double.slider(
      label: 'Grind Size',
      initialValue: 4.4,
      min: 1.0,
      max: 20.0,
    ),
    description: context.knobs.string(
      label: 'Description',
      initialValue: 'Soft, round aroma, mild',
    ),
    rating: context.knobs.double.slider(
      label: 'Rating',
      initialValue: 4.5,
      min: 1.0,
      max: 5.0,
    ),
    strength: context.knobs.int.slider(
      label: 'Strength',
      initialValue: 2,
      min: 1,
      max: 5,
    ),
    grinder: Grinder.create(
      brand: context.knobs.string(label: 'Grinder Brand', initialValue: 'Varia'),
      name: context.knobs.string(label: 'Grinder Model', initialValue: 'VS3'),
    ),
    machine: Machine.create(
      brand: context.knobs.string(label: 'Machine Brand', initialValue: 'Gaggia'),
      name: context.knobs.string(label: 'Machine Model', initialValue: 'Classic Evo Pro 2023'),
    ),
  );

  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BeanCard(
          profile: profile,
        ),
      ),
    ),
  );
}
