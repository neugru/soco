import 'package:flutter/material.dart';

import 'package:soco/ui/core/styles/elevation.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/soco_icons.dart';
import 'package:soco/ui/core/ui/widgets/library_app_bar.dart';
import 'package:soco/ui/core/ui/widgets/library_search_bar.dart';
import 'package:soco/ui/features/bean_library/models/bean.dart';
import 'package:soco/ui/features/bean_library/viewmodels/bean_library_viewmodel.dart';

class BeanLibraryView extends StatefulWidget {
  const BeanLibraryView({super.key});

  @override
  State<BeanLibraryView> createState() => _BeanLibraryViewState();
}

class _BeanLibraryViewState extends State<BeanLibraryView> {
  late final BeanLibraryViewModel _viewModel;
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _viewModel = BeanLibraryViewModel();
    _searchController = TextEditingController();
    _scrollController = ScrollController();

    // Fetch initial list
    _viewModel.fetchBeans();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  // Helper for roast level colors
  // TODO change colors
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

  // TODO change colors
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

  void _showAddBeanDialog() {
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
              title: const Text('Add Bean to Library'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Bean Name',
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
                      final newBean = Bean(
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
                      _viewModel.addBean(newBean);
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

    final navBarVerticalSpacing = AppSizes.spacing.medium;  // spacing above the BottomNavBar
    final safeAreaBottom = MediaQuery.paddingOf(context).bottom;
    // The "fabPadding" will level the FAB with the top of the BottomNavBar.
    // The FAB has 16px (additional) bottom padding by default (defined in
    // "kFloatingActionButtonMargin" by flutter itself), creating a gap of 16px
    // between the FAB and the BottomNavBar.
    // To set a custom gap, replace the fabPadding with the code below:
    // final fabGap = 12.0;  // custom gap
    // final fabPadding = safeAreaBottom - navBarVerticalSpacing - kFloatingActionButtonMargin + fabGap;
    final fabPadding = safeAreaBottom - navBarVerticalSpacing;
    final pageContentBottomPadding = safeAreaBottom + AppSizes.spacing.medium;

    return Scaffold(
      appBar: const LibraryAppBar(
        title: 'Bean Library',
        icon: SocoIcons.coffeeBean,
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: fabPadding), // Push FAB above the floating NavBar
        child: FloatingActionButton.extended(
          onPressed: _showAddBeanDialog,
          icon: Icon(SocoIcons.add),
          label: const Text('Add Bean'),
          foregroundColor: colorScheme.onPrimaryContainer,  // will be used by text and icon
        ),
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
                    'Loading beans...',
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
                child: LibrarySearchBar(
                  controller: _searchController,
                  hintText: 'Search brand, name, machine...',
                  onChanged: (val) => _viewModel.search(val),
                  onClear: () {
                    _searchController.clear();
                    _viewModel.search('');
                  },
                ),
              ),

              // Bean List
              Expanded(
                child: _viewModel.beans.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // TODO replace empty list icon
                            Icon(
                              SocoIcons.noImage,
                              size: 64,
                              color: colorScheme.outline.withValues(alpha: 0.5),
                            ),
                            AppSizes.gap.medium,
                            Text(
                              _viewModel.searchQuery.trim().isNotEmpty
                                  ? 'No beans matching your search'
                                  : 'Your bean library is empty',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: colorScheme.outline,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : Scrollbar(
                        controller: _scrollController,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            final topFadeHeight = AppSizes.spacing.medium;
                            final fadeEnd = (topFadeHeight / bounds.height).clamp(0.0, 1.0);

                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: const [
                                Colors.transparent,
                                Colors.black,
                              ],
                              stops: [0, fadeEnd],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.dstIn,
                          child: ListView.separated(
                            controller: _scrollController,
                            padding: EdgeInsets.only(
                              left: AppSizes.spacing.medium,
                              right: AppSizes.spacing.medium,
                              top: AppSizes.spacing.medium, // Keep top padding matching the fade zone
                              bottom: pageContentBottomPadding,
                            ),
                            itemCount: _viewModel.beans.length,
                            separatorBuilder: (context, index) => SizedBox(
                              height: AppSizes.spacing.medium,
                            ),
                            itemBuilder: (context, index) {
                              final bean = _viewModel.beans[index];

                              return Dismissible(
                                key: Key(bean.id),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing.large),
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
                                  _viewModel.removeBean(bean.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${bean.name} removed'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () => _viewModel.addBean(bean),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                child: _BeanCard(
                                  bean: bean,
                                  isDarkTheme: isDarkTheme,
                                  roastBgColor: _getRoastBgColor(bean.roastLevel, isDarkTheme),
                                  roastTextColor: _getRoastTextColor(bean.roastLevel, isDarkTheme),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// TODO re-design cards
class _BeanCard extends StatelessWidget {
  final Bean bean;
  final bool isDarkTheme;
  final Color roastBgColor;
  final Color roastTextColor;

  const _BeanCard({
    required this.bean,
    required this.isDarkTheme,
    required this.roastBgColor,
    required this.roastTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
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
                          bean.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                        ),
                        AppSizes.gap.extraSmall,
                        Text(
                          '${bean.brand} • ${bean.origin}',
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
                      'Grinder: ${bean.grinder}',
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
                      'Machine: ${bean.machine}',
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
                bean.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              AppSizes.gap.medium,
              // Footer: roast badge, grind size badge & star rating
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: AppSizes.spacing.small,
                runSpacing: AppSizes.spacing.small,
                children: [
                  Wrap(
                    spacing: AppSizes.spacing.small,
                    runSpacing: AppSizes.spacing.small,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: roastBgColor,
                          borderRadius: BorderRadius.circular(AppSizes.radius.small),
                        ),
                        child: Text(
                          bean.roastLevel.displayName,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: roastTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(AppSizes.radius.small),
                        ),
                        child: Text(
                          'Grind: ${bean.grindSize.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        SocoIcons.starRate,
                        color: Colors.amber,
                        size: 16,
                      ),
                      AppSizes.gap.extraSmall,
                      Text(
                        bean.rating.toStringAsFixed(1),
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
