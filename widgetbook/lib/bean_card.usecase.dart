import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:soco/core/models/bean.dart';
import 'package:soco/core/models/brew_profile.dart';
import 'package:soco/core/models/grinder.dart';
import 'package:soco/core/models/machine.dart';
import 'package:soco/core/models/roast_level.dart';
import 'package:soco/ui/features/bean_library/views/widgets/bean_card.dart';

Color _getRoastBgColor(RoastLevel level, bool isDarkTheme) {
  if (isDarkTheme) {
    switch (level) {
      case RoastLevel.light:
        return const Color(0xFF5C4E43);
      case RoastLevel.medium:
        return const Color(0xFF6B4B32);
      case RoastLevel.dark:
        return const Color(0xFF382F2D);
    }
  } else {
    switch (level) {
      case RoastLevel.light:
        return const Color(0xFFF5EBE6);
      case RoastLevel.medium:
        return const Color(0xFFEDDDD4);
      case RoastLevel.dark:
        return const Color(0xFFE2D4C9);
    }
  }
}

Color _getRoastTextColor(RoastLevel level, bool isDarkTheme) {
  if (isDarkTheme) {
    switch (level) {
      case RoastLevel.light:
        return const Color(0xFFFBECE2);
      case RoastLevel.medium:
        return const Color(0xFFFFE0CC);
      case RoastLevel.dark:
        return const Color(0xFFE6D6D2);
    }
  } else {
    switch (level) {
      case RoastLevel.light:
        return const Color(0xFF8D5B4C);
      case RoastLevel.medium:
        return const Color(0xFF9E4B28);
      case RoastLevel.dark:
        return const Color(0xFF5E463E);
    }
  }
}

@widgetbook.UseCase(name: 'Default', type: BeanCard)
Widget buildBeanCardUseCase(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final roast = context.knobs.object.dropdown<RoastLevel>(
    label: 'Roast Level',
    initialOption: RoastLevel.medium,
    options: RoastLevel.values,
    labelBuilder: (level) => level.displayName,
  );

  final profile = BrewProfile.create(
    bean: Bean.create(
      name: context.knobs.string(label: 'Bean Name', initialValue: 'Ethiopia Yirgacheffe'),
      brand: context.knobs.string(label: 'Brand', initialValue: 'Coffee Collective'),
      origin: context.knobs.string(label: 'Origin', initialValue: 'Yirgacheffe, Ethiopia'),
      roastLevel: roast,
    ),
    grindSize: context.knobs.double.slider(
      label: 'Grind Size',
      initialValue: 14.5,
      min: 1.0,
      max: 40.0,
    ),
    description: context.knobs.string(
      label: 'Description',
      initialValue: 'Floral notes of jasmine and sweet peach with a clean tea-like finish.',
    ),
    rating: context.knobs.double.slider(
      label: 'Rating',
      initialValue: 4.8,
      min: 1.0,
      max: 5.0,
    ),
    strength: context.knobs.int.slider(
      label: 'Strength',
      initialValue: 3,
      min: 1,
      max: 5,
    ),
    grinder: Grinder.create(
      brand: context.knobs.string(label: 'Grinder Brand', initialValue: 'Mahlkönig'),
      name: context.knobs.string(label: 'Grinder Model', initialValue: 'EK43S'),
    ),
    machine: Machine.create(
      brand: context.knobs.string(label: 'Machine Brand', initialValue: 'La Marzocco'),
      name: context.knobs.string(label: 'Machine Model', initialValue: 'Linea Micra'),
    ),
  );

  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BeanCard(
          profile: profile,
          isDarkTheme: isDark,
          roastBgColor: _getRoastBgColor(roast, isDark),
          roastTextColor: _getRoastTextColor(roast, isDark),
        ),
      ),
    ),
  );
}
