import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soco/utils/constants/assets.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/elevation.dart';
import '../models/coffee.dart';
import '../viewmodels/coffee_library_viewmodel.dart';

class CoffeeLibraryView extends StatefulWidget {
  const CoffeeLibraryView({super.key});

  @override
  State<CoffeeLibraryView> createState() => _CoffeeLibraryViewState();
}

class _CoffeeLibraryViewState extends State<CoffeeLibraryView> {
  late final CoffeeLibraryViewModel _viewModel;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _viewModel = CoffeeLibraryViewModel();
    _searchController = TextEditingController();

    // Fetch initial list
    _viewModel.fetchCoffees();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  // Helper for roast level colors
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

  void _showAddCoffeeDialog() {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String brand = '';
    double grindSize = 14.00;
    String origin = '';
    String description = '';
    RoastLevel roastLevel = RoastLevel.medium;
    double rating = 4.5;
    String grinder = '';
    String machine = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add Coffee to Library'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Coffee Name',
                          hintText: 'e.g. Geisha Natural',
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please enter a name' : null,
                        onSaved: (v) => name = v ?? '',
                      ),
                      AppSizes.gap.small,
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Brand',
                          hintText: 'e.g. Sey Coffee',
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please enter a brand' : null,
                        onSaved: (v) => brand = v ?? '',
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
                        onSaved: (v) => grindSize = double.tryParse(v ?? '') ?? 14.00,
                      ),
                      AppSizes.gap.small,
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Origin',
                          hintText: 'e.g. Panama (Single Origin)',
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please enter origin' : null,
                        onSaved: (v) => origin = v ?? '',
                      ),
                      AppSizes.gap.small,
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Grinder Used',
                          hintText: 'e.g. Comandante C40',
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please enter grinder' : null,
                        onSaved: (v) => grinder = v ?? '',
                      ),
                      AppSizes.gap.small,
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Machine Used',
                          hintText: 'e.g. Decent DE1PRO',
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please enter machine' : null,
                        onSaved: (v) => machine = v ?? '',
                      ),
                      AppSizes.gap.small,
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Description / Tasting Notes',
                          hintText: 'e.g. Bergamot, peach, black tea finish.',
                        ),
                        maxLines: 2,
                        onSaved: (v) => description = v ?? '',
                      ),
                      AppSizes.gap.medium,
                      // Roast Level selection
                      Row(
                        children: [
                          const Text('Roast Level: '),
                          AppSizes.gap.medium,
                          Expanded(
                            child: DropdownButton<RoastLevel>(
                              value: roastLevel,
                              isExpanded: true,
                              items: RoastLevel.values.map((level) {
                                return DropdownMenuItem(
                                  value: level,
                                  child: Text(level.displayName),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setDialogState(() {
                                    roastLevel = val;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      AppSizes.gap.medium,
                      // Rating slider
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rating: ${rating.toStringAsFixed(1)} Stars'),
                          Slider(
                            value: rating,
                            min: 1.0,
                            max: 5.0,
                            divisions: 40,
                            onChanged: (val) {
                              setDialogState(() {
                                rating = val;
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
                    if (formKey.currentState?.validate() ?? false) {
                      formKey.currentState?.save();
                      final newCoffee = Coffee(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: name,
                        brand: brand,
                        grindSize: grindSize,
                        origin: origin,
                        roastLevel: roastLevel,
                        description: description.isEmpty ? 'No description provided.' : description,
                        rating: rating,
                        grinder: grinder,
                        machine: machine,
                      );
                      _viewModel.addCoffee(newCoffee);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$name added successfully!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              AppAssets.icons.coffee,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            AppSizes.gap.small,
            Text(
              'Coffee Library',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCoffeeDialog,
        icon: SvgPicture.asset(
          AppAssets.icons.add,
          colorFilter: ColorFilter.mode(
            colorScheme.onPrimary,
            BlendMode.srcIn,
          ),
        ),
        label: const Text('Add Coffee'),
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  AppSizes.gap.medium,
                  Text(
                    'Brewing list...',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.outline,
                        ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Search Bar Area
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.spacing.medium,
                  vertical: AppSizes.spacing.small,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppSizes.radius.large),
                    boxShadow: AppElevation.shadows.low,
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) => _viewModel.search(val),
                    decoration: InputDecoration(
                      hintText: 'Search brand, name, machine...',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          AppAssets.icons.search,
                          colorFilter: ColorFilter.mode(
                            colorScheme.outline,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      suffixIcon: _viewModel.searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _viewModel.search('');
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
              ),

              // Coffee List
              Expanded(
                child: _viewModel.coffees.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssets.icons.noImage,
                              height: 64,
                              colorFilter: ColorFilter.mode(
                                colorScheme.outline.withValues(alpha: 0.5),
                                BlendMode.srcIn,
                              ),
                            ),
                            AppSizes.gap.medium,
                            Text(
                              _viewModel.searchQuery.trim().isNotEmpty
                                  ? 'No coffees match your search.'
                                  : 'Your library is empty.',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: colorScheme.outline,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(
                          left: AppSizes.spacing.medium,
                          right: AppSizes.spacing.medium,
                          top: AppSizes.spacing.small,
                          bottom: AppSizes.spacing.extraLarge2 + 16.0,
                        ),
                        itemCount: _viewModel.coffees.length,
                        itemBuilder: (context, index) {
                          final coffee = _viewModel.coffees[index];

                          return Dismissible(
                            key: Key(coffee.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing.large),
                              margin: EdgeInsets.only(bottom: AppSizes.spacing.medium),
                              decoration: BoxDecoration(
                                color: colorScheme.errorContainer,
                                borderRadius: BorderRadius.circular(AppSizes.radius.large),
                              ),
                              child: Icon(
                                Icons.delete_outline,
                                color: colorScheme.onErrorContainer,
                                size: 28,
                              ),
                            ),
                            onDismissed: (direction) {
                              _viewModel.removeCoffee(coffee.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${coffee.name} removed'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () => _viewModel.addCoffee(coffee),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            child: _CoffeeCard(
                              coffee: coffee,
                              isDarkTheme: isDarkTheme,
                              roastBgColor: _getRoastBgColor(coffee.roastLevel, isDarkTheme),
                              roastTextColor: _getRoastTextColor(coffee.roastLevel, isDarkTheme),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CoffeeCard extends StatelessWidget {
  final Coffee coffee;
  final bool isDarkTheme;
  final Color roastBgColor;
  final Color roastTextColor;

  const _CoffeeCard({
    required this.coffee,
    required this.isDarkTheme,
    required this.roastBgColor,
    required this.roastTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.spacing.medium),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppSizes.radius.large),
        boxShadow: AppElevation.shadows.low,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radius.large),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spacing.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title, Brand & Origin
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coffee.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                        ),
                        AppSizes.gap.extraSmall,
                        Text(
                          '${coffee.brand} • ${coffee.origin}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.outline,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSizes.gap.small,
              // Equipment Details (Grinder & Machine)
              Row(
                children: [
                  Icon(Icons.tune, size: 14, color: colorScheme.outline),
                  AppSizes.gap.extraSmall,
                  Expanded(
                    child: Text(
                      'Grinder: ${coffee.grinder}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AppSizes.gap.small,
                  Icon(Icons.coffee_maker_outlined, size: 14, color: colorScheme.outline),
                  AppSizes.gap.extraSmall,
                  Expanded(
                    child: Text(
                      'Machine: ${coffee.machine}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              AppSizes.gap.small,
              // Description
              Text(
                coffee.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              AppSizes.gap.medium,
              // Footer: roast badge, grind size badge & star rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: roastBgColor,
                          borderRadius: BorderRadius.circular(AppSizes.radius.small),
                        ),
                        child: Text(
                          coffee.roastLevel.displayName,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: roastTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      AppSizes.gap.small,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(AppSizes.radius.small),
                        ),
                        child: Text(
                          'Grind: ${coffee.grindSize.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.icons.starRate,
                        colorFilter: const ColorFilter.mode(
                          Colors.amber,
                          BlendMode.srcIn,
                        ),
                        height: 16,
                        width: 16,
                      ),
                      AppSizes.gap.extraSmall,
                      Text(
                        coffee.rating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
