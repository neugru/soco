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
  RoastLevel _roastLevel = RoastLevel.medium;
  int _strength = 3;
  String _machine = '';
  String _grinder = '';
  double _dose = 18.0;
  double _grindSize = 14.00;
  double _brewYield = 36.0;
  int _brewTime = 30;
  String _description = '';
  double _rating = 4.5;

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
                  labelText: 'Grind Size',
                  hintText: 'e.g. 14.50',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter grind size';
                  if (double.tryParse(v) == null) return 'Please enter a valid number';
                  return null;
                },
                onSaved: (v) => _grindSize = double.tryParse(v ?? '') ?? 14.00,
              ),
              AppSizes.gap.small,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Dose (g)',
                  hintText: 'e.g. 18.0',
                ),
                initialValue: '18.0',
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
                initialValue: '36.0',
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
                initialValue: '30',
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter brew time';
                  if (int.tryParse(v) == null) return 'Please enter a valid integer';
                  return null;
                },
                onSaved: (v) => _brewTime = int.tryParse(v ?? '') ?? 30,
              ),
              AppSizes.gap.small,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Origin',
                  hintText: 'e.g. Panama (Single Origin)',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Please enter origin' : null,
                onSaved: (v) => _origin = v ?? '',
              ),
              AppSizes.gap.small,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Grinder Used',
                  hintText: 'e.g. Comandante C40',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Please enter grinder' : null,
                onSaved: (v) => _grinder = v ?? '',
              ),
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
                  labelText: 'Description / Tasting Notes',
                  hintText: 'e.g. Bergamot, peach, black tea finish.',
                ),
                maxLines: 2,
                onSaved: (v) => _description = v ?? '',
              ),
              AppSizes.gap.medium,
              // Roast Level selection
              Row(
                children: [
                  const Text('Roast Level: '),
                  AppSizes.gap.medium,
                  Expanded(
                    child: DropdownButton<RoastLevel>(
                      value: _roastLevel,
                      isExpanded: true,
                      items: RoastLevel.values.map((level) {
                        return DropdownMenuItem(
                          value: level,
                          child: Text(level.displayName),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _roastLevel = val;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              AppSizes.gap.medium,
              // Strength meter picker
              Row(
                children: [
                  Text(
                    'Strength: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  AppSizes.gap.medium,
                  Row(
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
                          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                          child: Icon(
                            SocoIcons.coffeeBean,
                            size: 26,
                            color: isActive ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.15),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              AppSizes.gap.medium,
              // Rating slider
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rating: ${_rating.toStringAsFixed(1)} Stars'),
                  Slider(
                    value: _rating,
                    min: 1.0,
                    max: 5.0,
                    divisions: 40,
                    onChanged: (val) {
                      setState(() {
                        _rating = val;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
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
                roastLevel: _roastLevel,
                strength: _strength,
              );

              final newProfile = BrewProfile.create(
                bean: newBean,
                machine: _parseMachine(_machine),
                grinder: _parseGrinder(_grinder),
                dose: _dose,
                grindSize: _grindSize,
                brewYield: _brewYield,
                brewTimeSeconds: _brewTime,
                description: _description.isEmpty ? 'No description provided.' : _description,
                rating: _rating,
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
