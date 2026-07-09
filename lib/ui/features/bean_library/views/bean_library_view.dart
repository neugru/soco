import 'package:flutter/material.dart';

import 'package:soco/core/models/brew_profile.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/soco_icons.dart';
import 'package:soco/ui/core/ui/widgets/library_app_bar.dart';
import 'package:soco/ui/core/ui/widgets/library_search_bar.dart';
import 'package:soco/ui/features/bean_library/viewmodels/bean_library_viewmodel.dart';
import 'package:soco/ui/features/bean_library/views/add_bean_dialog.dart';
import 'package:soco/ui/features/bean_library/views/widgets/bean_card.dart';

class BeanLibraryView extends StatefulWidget {
  const BeanLibraryView({super.key});

  @override
  State<BeanLibraryView> createState() => _BeanLibraryViewState();
}

class _BeanLibraryViewState extends State<BeanLibraryView> {
  late final BeanLibraryViewModel _viewModel;
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  bool _isExpanded = true;  // TODO remove after testing

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



  void _showAddBeanDialog() async {
    final newProfile = await showDialog<BrewProfile>(
      context: context,
      builder: (context) => const AddBeanDialog(),
    );

    if (newProfile != null && mounted) {
      _viewModel.addBrewProfile(newProfile);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${newProfile.bean.name} added successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final navBarVerticalSpacing = AppSizes.spacing.medium; // spacing above the BottomNavBar
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
          foregroundColor: colorScheme.onPrimaryContainer, // will be used by text and icon
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

              // TODO remove after testing
              // Temporary Expanded Switch Row
              Padding(
                padding: EdgeInsets.only(
                  left: AppSizes.spacing.medium,
                  right: AppSizes.spacing.medium,
                  bottom: AppSizes.spacing.small,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expanded Card View',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Switch(
                      value: _isExpanded,
                      onChanged: (val) {
                        setState(() {
                          _isExpanded = val;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Bean List
              Expanded(
                child: _viewModel.brewProfiles.isEmpty
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
                                  ? 'No profiles matching your search'
                                  : 'Your profile library is empty',
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
                            itemCount: _viewModel.brewProfiles.length,
                            separatorBuilder: (context, index) => SizedBox(
                              height: AppSizes.spacing.medium,
                            ),
                            itemBuilder: (context, index) {
                              final profile = _viewModel.brewProfiles[index];

                              return Dismissible(
                                key: Key(profile.id),
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
                                  _viewModel.removeBrewProfile(profile.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${profile.bean.name} removed'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () => _viewModel.addBrewProfile(profile),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                child: BeanCard(
                                  profile: profile,
                                  isCompact: !_isExpanded,  // TODO remove after testing
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

