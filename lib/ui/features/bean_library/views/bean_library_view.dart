import 'package:flutter/material.dart';

import 'package:soco/core/models/brew_profile.dart';
import 'package:soco/ui/core/styles/assets.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/icons.dart';
import 'package:soco/ui/core/ui/widgets/empty_library_view.dart';
import 'package:soco/ui/core/ui/widgets/fading_mask.dart';
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

  bool _isExpanded = false; // TODO remove after testing

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

    final navBarVerticalSpacing = SocoSizes.spacing.medium; // spacing above the BottomNavBar
    final safeAreaBottom = MediaQuery.paddingOf(context).bottom;
    // The "fabPadding" will level the FAB with the top of the BottomNavBar.
    // The FAB has 16px (additional) bottom padding by default (defined in
    // "kFloatingActionButtonMargin" by flutter itself), creating a gap of 16px
    // between the FAB and the BottomNavBar.
    // To set a custom gap, replace the fabPadding with the code below:
    // final fabGap = 12.0;  // custom gap
    // final fabPadding = safeAreaBottom - navBarVerticalSpacing - kFloatingActionButtonMargin + fabGap;
    final fabPadding = (safeAreaBottom - navBarVerticalSpacing).clamp(0.0, double.infinity);
    final pageContentBottomPadding = safeAreaBottom + SocoSizes.spacing.medium;

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
                  SocoSizes.gap.medium,
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
                  horizontal: SocoSizes.spacing.medium,
                  vertical: SocoSizes.spacing.small,
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
                  left: SocoSizes.spacing.medium,
                  right: SocoSizes.spacing.medium,
                  bottom: SocoSizes.spacing.small,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expanded Cards',
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
                    ? EmptyLibraryView(
                        message: "No beans? That's depresso.\nAdd some and start brewing!",
                        searchMessage: "No beans found matching your search",
                        asset: SocoAssets.sleepyBean,
                        searchIcon: SocoIcons.searchOff,
                        searchQuery: _viewModel.searchQuery,
                        bottomPadding: pageContentBottomPadding, 
                      )
                    : _BeanProfileList(
                        viewModel: _viewModel,
                        scrollController: _scrollController,
                        isExpanded: _isExpanded,
                        bottomPadding: pageContentBottomPadding,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}



class _BeanProfileList extends StatelessWidget {
  final BeanLibraryViewModel viewModel;
  final ScrollController scrollController;
  final bool isExpanded;
  final double bottomPadding;

  const _BeanProfileList({
    required this.viewModel,
    required this.scrollController,
    required this.isExpanded,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scrollbar(
      controller: scrollController,
      child: FadingMask(
        fadeHeightTop: SocoSizes.spacing.medium,
        child: ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.only(
            left: SocoSizes.spacing.medium,
            right: SocoSizes.spacing.medium,
            top: SocoSizes.spacing.medium, // Keep top padding matching the fade zone
            bottom: bottomPadding,
          ),
          itemCount: viewModel.brewProfiles.length,
          separatorBuilder: (context, index) => SizedBox(
            height: SocoSizes.spacing.medium,
          ),
          itemBuilder: (context, index) {
            final profile = viewModel.brewProfiles[index];

            return Stack(
              // borderRadius: BorderRadius.circular(AppSizes.radius.large),
              children: [
                // Static background to fill the corner gaps during swipe
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(SocoSizes.radius.large),
                    ),
                  ),
                ),
                // Swipeable Bean Card
                Dismissible(
                  key: Key(profile.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: SocoSizes.spacing.large),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SocoSizes.radius.large),
                    ),
                    child: Icon(
                      SocoIcons.deleteOutline,
                      color: colorScheme.onErrorContainer,
                      size: SocoSizes.icon.extraLarge,
                    ),
                  ),
                  onDismissed: (direction) {
                    viewModel.removeBrewProfile(profile.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${profile.bean.name} removed'),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 4),
                        persist: false, // auto-dismiss after specified duration
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () => viewModel.addBrewProfile(profile),
                        ),
                      ),
                    );
                  },
                  child: BeanCard(
                    profile: profile,
                    isExpanded: isExpanded,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
