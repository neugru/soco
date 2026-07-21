import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:soco/core/models/bean.dart';
import 'package:soco/core/models/brew_profile.dart';
import 'package:soco/core/models/grinder.dart';
import 'package:soco/core/models/machine.dart';
import 'package:soco/core/models/roast_level.dart';
import 'package:soco/ui/core/styles/metrics.dart' as soco_metrics;
import 'package:soco/ui/core/styles/icons.dart';

class AddBeanDialog extends StatefulWidget {
  const AddBeanDialog({super.key});

  @override
  State<AddBeanDialog> createState() => _AddBeanDialogState();
}

class _AddBeanDialogState extends State<AddBeanDialog> {
  final _formKey = GlobalKey<FormState>();

  // TODO: Load initial values from ViewModel
  final double _dose = 18;
  final double _yield = 42.0;
  final int _brewTimeSeconds = 30;

  // Controllers for text inputs
  late final _nameController = TextEditingController();
  late final _brandController = TextEditingController();
  late final _originController = TextEditingController();
  late final _machineController = TextEditingController();
  late final _grinderController = TextEditingController();
  late final _grindSizeController = TextEditingController();
  late final _doseController = TextEditingController(text: _formatDouble(_dose));
  late final _yieldController = TextEditingController(text: _formatDouble(_yield));
  late final _brewTimeController = TextEditingController(text: _brewTimeSeconds.toString());
  late final _descriptionController = TextEditingController();

  // Focus nodes for decimal inputs
  late final _grindSizeFocusNode = FocusNode();
  late final _doseFocusNode = FocusNode();
  late final _yieldFocusNode = FocusNode();

  // Track last text inputs to distinguish typing from backspacing
  final Map<TextEditingController, String> _lastTextMap = {};

  // Non-text state fields
  int _strength = 3;
  RoastLevel? _roastLevel;
  bool _submitted = false;

  /// Formates a double value as a string.
  ///
  /// If the value is a whole number (e.g. `18.0`), it removes the trailing `.0`
  /// and returns it as an integer string (`"18"`). Otherwise, it displays
  /// the full decimal string (e.g. `4.4` -> `"4.4"`).
  String _formatDouble(double value) {
    // If the value is a whole number, display it as an integer (removes trailing .0)
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  @override
  void initState() {
    super.initState();
    // Listen to changes on required fields to update button disabled state
    _nameController.addListener(_onFormChanged);
    _brandController.addListener(_onFormChanged);
    _machineController.addListener(_onFormChanged);
    _grindSizeController.addListener(_onFormChanged);
    _doseController.addListener(_onFormChanged);
    _yieldController.addListener(_onFormChanged);
    _brewTimeController.addListener(_onFormChanged);

    // Track initial values for decimal fields
    _lastTextMap[_grindSizeController] = _grindSizeController.text;
    _lastTextMap[_doseController] = _doseController.text;
    _lastTextMap[_yieldController] = _yieldController.text;

    // Attach float listeners for advanced auto-formatting
    _setupDecimalController(_grindSizeFocusNode, _grindSizeController);
    _setupDecimalController(_doseFocusNode, _doseController);
    _setupDecimalController(_yieldFocusNode, _yieldController);
  }

  void _onFormChanged() {
    setState(() {});
  }

  void _setupDecimalController(FocusNode focusNode, TextEditingController controller) {
    // 1. Real-time typing formatter
    controller.addListener(() {
      final text = controller.text;
      final lastText = _lastTextMap[controller] ?? '';
      _lastTextMap[controller] = text;

      // Inject '0' and select it only if user typed '.' (input length increased)
      if (text.length > lastText.length && !lastText.endsWith('.') && text.endsWith('.')) {
        final newText = '${text}0';
        controller.value = TextEditingValue(
          text: newText,
          selection: TextSelection(
            baseOffset: text.length,
            extentOffset: text.length + 1,
          ),
        );
        _lastTextMap[controller] = newText;
      }
    });

    // 2. Lost focus formatter (cleanup on tap out)
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        final text = controller.text.trim();
        if (text.endsWith('.') || text.endsWith('.0')) {
          controller.text = text.replaceAll(RegExp(r'\.0?$'), '');
        }
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _originController.dispose();
    _machineController.dispose();
    _grinderController.dispose();
    _doseController.dispose();
    _grindSizeController.dispose();
    _yieldController.dispose();
    _brewTimeController.dispose();
    _descriptionController.dispose();

    _grindSizeFocusNode.dispose();
    _doseFocusNode.dispose();
    _yieldFocusNode.dispose();
    super.dispose();
  }

  // TODO: replace with Machine Data Object (select machine from list)
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

  // TODO: replace with Grinder Data Object (select grinder from list)
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

  Widget _buildValidationIcon(bool isValid, ColorScheme colorScheme) {
    return Icon(
      isValid ? SocoIcons.checkCircleOutlined : SocoIcons.infoOutline,
      color: isValid ? Colors.green.withValues(alpha: 0.4) : colorScheme.error.withValues(alpha: 0.4),
      size: soco_metrics.icon.medium,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AlertDialog(
        title: const Text('Add Bean to Library'),
        content: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: soco_metrics.spacing.small,
            bottom: soco_metrics.spacing.large,
            left: soco_metrics.spacing.xSmall,
            right: soco_metrics.spacing.xSmall,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    labelText: 'Bean Name',
                    hintText: 'e.g. Espresso Roma',
                    suffixIcon: _buildValidationIcon(_nameController.text.trim().isNotEmpty, colorScheme),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Please enter a name' : null,
                ),

                soco_metrics.verticalBox.small,

                TextFormField(
                  controller: _brandController,
                  autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    labelText: 'Brand',
                    hintText: 'e.g. Ettli',
                    suffixIcon: _buildValidationIcon(_brandController.text.trim().isNotEmpty, colorScheme),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Please enter a brand' : null,
                ),

                soco_metrics.verticalBox.small,

                TextFormField(
                  controller: _originController,
                  decoration: const InputDecoration(
                    labelText: 'Origin',
                    hintText: 'e.g. South-/Central-America',
                  ),
                ),

                soco_metrics.verticalBox.small,

                FormField<RoastLevel?>(
                  initialValue: _roastLevel,
                  onSaved: (val) => _roastLevel = val,
                  builder: (FormFieldState<RoastLevel?> state) {
                    return DropdownMenu<RoastLevel?>(
                      initialSelection: state.value,
                      expandedInsets: EdgeInsets.zero,
                      requestFocusOnTap: false,
                      inputDecorationTheme: Theme.of(context).inputDecorationTheme,
                      textStyle: state.value == null ? const TextStyle(fontStyle: FontStyle.italic) : null,
                      label: const Text('Roast Level'),
                      errorText: state.errorText,
                      dropdownMenuEntries: [
                        const DropdownMenuEntry<RoastLevel?>(
                          value: null,
                          label: '-- Not Specified --',
                          labelWidget: Text(
                            '-- Not Specified --',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        ...RoastLevel.values.map((level) {
                          return DropdownMenuEntry<RoastLevel?>(
                            value: level,
                            label: level.displayName,
                          );
                        }),
                      ],
                      onSelected: (val) {
                        state.didChange(val);
                        setState(() {
                          _roastLevel = val;
                        });
                      },
                    );
                  },
                ),

                soco_metrics.verticalBox.small,

                InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Strength',
                    border: InputBorder.none,
                    filled: false,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: soco_metrics.spacing.xSmall),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 2,
                      children: List.generate(5, (index) {
                        final beanValue = index + 1;
                        final isActive = beanValue <= _strength;
                        return IconButton(
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: const Icon(SocoIcons.coffeeBean),
                          iconSize: soco_metrics.icon.xLarge,
                          color: isActive ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.15),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _strength = beanValue;
                            });
                          },
                        );
                      }),
                    ),
                  ),
                ),

                const Divider(),
                soco_metrics.verticalBox.small,

                TextFormField(
                  controller: _grindSizeController,
                  focusNode: _grindSizeFocusNode,
                  autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    labelText: 'Grind Size',
                    hintText: 'e.g. 4.4',
                    suffixIcon: _buildValidationIcon(double.tryParse(_grindSizeController.text) != null, colorScheme),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter grind size';
                    if (double.tryParse(v) == null) return 'Please enter a valid number';
                    return null;
                  },
                ),

                soco_metrics.verticalBox.small,

                TextFormField(
                  controller: _doseController,
                  focusNode: _doseFocusNode,
                  autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    labelText: 'Dose (g)',
                    hintText: 'e.g. 18.0',
                    suffixIcon: _buildValidationIcon(double.tryParse(_doseController.text) != null, colorScheme),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter dose';
                    if (double.tryParse(v) == null) return 'Please enter a valid number';
                    return null;
                  },
                ),

                soco_metrics.verticalBox.small,

                TextFormField(
                  controller: _yieldController,
                  focusNode: _yieldFocusNode,
                  autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    labelText: 'Yield (g)',
                    hintText: 'e.g. 42.0',
                    suffixIcon: _buildValidationIcon(double.tryParse(_yieldController.text) != null, colorScheme),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter yield';
                    if (double.tryParse(v) == null) return 'Please enter a valid number';
                    return null;
                  },
                ),

                soco_metrics.verticalBox.small,

                TextFormField(
                  controller: _brewTimeController,
                  autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    labelText: 'Brew Time (s)',
                    hintText: 'e.g. 25',
                    suffixIcon: _buildValidationIcon(int.tryParse(_brewTimeController.text) != null, colorScheme),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter brew time';
                    if (int.tryParse(v) == null) return 'Please enter a valid integer';
                    return null;
                  },
                ),

                soco_metrics.verticalBox.small,
                const Divider(),
                soco_metrics.verticalBox.small,

                // TODO: replace with Machine Data Object (select machine from list)
                TextFormField(
                  controller: _machineController,
                  autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    labelText: 'Machine Used',
                    hintText: 'e.g. Gaggia Classic Evo Pro 2023',
                    suffixIcon: _buildValidationIcon(_machineController.text.trim().isNotEmpty, colorScheme),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Please choose a machine' : null,
                ),
                soco_metrics.verticalBox.small,
                // TODO: replace with Grinder Data Object (select grinder from list)
                TextFormField(
                  controller: _grinderController,
                  decoration: const InputDecoration(
                    labelText: 'Grinder Used',
                    hintText: 'e.g. Varia VS3',
                  ),
                ),

                soco_metrics.verticalBox.small,
                const Divider(),
                soco_metrics.verticalBox.small,

                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description / Tasting Notes',
                    hintText: 'e.g. Soft, round aroma, mild',
                  ),
                  maxLines: 4,
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
          FilledButton(
            onPressed: () {
              setState(() {
                _submitted = true;
              });
              if (_formKey.currentState?.validate() ?? false) {
                final newBean = Bean.create(
                  name: _nameController.text.trim(),
                  brand: _brandController.text.trim(),
                  strength: _strength,
                  origin: _originController.text.trim().isEmpty ? null : _originController.text.trim(),
                  roastLevel: _roastLevel,
                );

                final newProfile = BrewProfile.create(
                  bean: newBean,
                  dose: double.parse(_doseController.text),
                  brewYield: double.parse(_yieldController.text),
                  grindSize: double.parse(_grindSizeController.text),
                  brewTimeSeconds: int.parse(_brewTimeController.text),
                  // TODO: replace with Machine Data Object (select machine from list)
                  machine: _parseMachine(_machineController.text),
                  // TODO: replace with Grinder Data Object (select grinder from list)
                  grinder: _grinderController.text.trim().isEmpty ? null : _parseGrinder(_grinderController.text),
                  description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
                );

                Navigator.of(context).pop(newProfile);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
