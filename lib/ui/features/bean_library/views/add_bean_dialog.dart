import 'package:flutter/material.dart';

import 'package:soco/core/models/bean.dart';
import 'package:soco/core/models/brew_profile.dart';
import 'package:soco/core/models/grinder.dart';
import 'package:soco/core/models/machine.dart';
import 'package:soco/core/models/roast_level.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/soco_icons.dart';

class AddBeanDialog extends StatefulWidget {
  const AddBeanDialog({super.key});

  @override
  State<AddBeanDialog> createState() => _AddBeanDialogState();
}

class _AddBeanDialogState extends State<AddBeanDialog> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _brand = '';
  String _origin = '';
  int _strength = 3;
  RoastLevel? _roastLevel;
  String _machine = '';
  String _grinder = '';
  double _dose = 18.0;
  double _grindSize = 14.00;
  double _brewYield = 36.0;
  int _brewTime = 30;
  String _description = '';

  Grinder _parseGrinder(String text) {
    final trimmed = text.trim();
    final parts = trimmed.split(' ');
    if (parts.length > 1) {
      return Grinder.create(
        brand: parts[0],
        name: parts.sublist(1).join(' '),
      );
    }
    return Grinder.create(
      brand: '',
      name: trimmed,
    );
  }

  Machine _parseMachine(String text) {
    final trimmed = text.trim();
    final parts = trimmed.split(' ');
    if (parts.length > 1) {
      return Machine.create(
        brand: parts[0],
        name: parts.sublist(1).join(' '),
      );
    }
    return Machine.create(
      brand: '',
      name: trimmed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: const Text('Add Bean to Library'),
      content: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: AppSizes.spacing.small,
          bottom: AppSizes.spacing.large,
          left: AppSizes.spacing.extraSmall,
          right: AppSizes.spacing.extraSmall,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Bean Name',
                  hintText: 'e.g. Geisha Natural',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Please enter a name' : null,
                onSaved: (v) => _name = v ?? '',
              ),
              AppSizes.gap.small,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Brand',
                  hintText: 'e.g. Sey Coffee',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Please enter a brand' : null,
                onSaved: (v) => _brand = v ?? '',
              ),
              AppSizes.gap.small,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Origin',
                  hintText: 'e.g. Panama (Single Origin)',
                ),
                onSaved: (v) => _origin = v ?? '',
              ),
              AppSizes.gap.small,
              DropdownButtonFormField<RoastLevel?>(
                initialValue: _roastLevel,
                decoration: const InputDecoration(
                  labelText: 'Roast Level',
                ),
                dropdownColor: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSizes.radius.medium),
                items: [
                  const DropdownMenuItem<RoastLevel?>(
                    value: null,
                    child: Text('Not Specified'),
                  ),
                  ...RoastLevel.values.map((level) {
                    return DropdownMenuItem<RoastLevel?>(
                      value: level,
                      child: Text(level.displayName),
                    );
                  }),
                ],
                onChanged: (val) {
                  setState(() {
                    _roastLevel = val;
                  });
                },
              ),
              AppSizes.gap.small,
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Strength',
                  border: InputBorder.none,
                  filled: false,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: AppSizes.spacing.extraSmall),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      final beanValue = index + 1;
                      final isActive = beanValue <= _strength;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _strength = beanValue;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            SocoIcons.coffeeBean,
                            size: 24,
                            color: isActive ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.15),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              AppSizes.gap.small,
              Divider(),
              AppSizes.gap.small,
              // AppSizes.gap.large,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Grind Size',
                  hintText: 'e.g. 14.50',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter grind size';
                  if (double.tryParse(v) == null) return 'Please enter a valid number';
                  return null;
                },
                onSaved: (v) => _grindSize = double.tryParse(v ?? '') ?? 14.5,
              ),
              AppSizes.gap.small,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Dose (g)',
                  hintText: 'e.g. 18.0',
                ),
                // initialValue: '18.0', // TODO set initial value through settings
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter dose';
                  if (double.tryParse(v) == null) return 'Please enter a valid number';
                  return null;
                },
                onSaved: (v) => _dose = double.tryParse(v ?? '') ?? 18.0,
              ),
              AppSizes.gap.small,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Yield (g)',
                  hintText: 'e.g. 36.0',
                ),
                // initialValue: '36.0', // TODO set initial value through settings
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter yield';
                  if (double.tryParse(v) == null) return 'Please enter a valid number';
                  return null;
                },
                onSaved: (v) => _brewYield = double.tryParse(v ?? '') ?? 36.0,
              ),
              AppSizes.gap.small,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Brew Time (s)',
                  hintText: 'e.g. 30',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter brew time';
                  if (int.tryParse(v) == null) return 'Please enter a valid integer';
                  return null;
                },
                onSaved: (v) => _brewTime = int.tryParse(v ?? '') ?? 30,
              ),
              AppSizes.gap.small,
              Divider(),
              AppSizes.gap.small,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Machine Used',
                  hintText: 'e.g. Decent DE1PRO',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Please enter machine' : null,
                onSaved: (v) => _machine = v ?? '',
              ),
              AppSizes.gap.small,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Grinder Used',
                  hintText: 'e.g. Comandante C40',
                ),
                onSaved: (v) => _grinder = v ?? '',
              ),
              AppSizes.gap.small,
              Divider(),
              AppSizes.gap.small,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description / Tasting Notes',
                  hintText: 'e.g. Bergamot, peach, black tea finish.',
                ),
                maxLines: 2,
                onSaved: (v) => _description = v ?? '',
              ),
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();

              final newBean = Bean.create(
                name: _name,
                brand: _brand,
                origin: _origin,
                strength: _strength,
                roastLevel: _roastLevel,
              );

              final newProfile = BrewProfile.create(
                bean: newBean,
                dose: _dose,
                grindSize: _grindSize,
                brewYield: _brewYield,
                brewTimeSeconds: _brewTime,
                machine: _parseMachine(_machine),
                grinder: _grinder.trim().isEmpty ? null : _parseGrinder(_grinder),
                description: _description.trim().isEmpty ? null : _description.trim(),
              );

              Navigator.of(context).pop(newProfile);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
