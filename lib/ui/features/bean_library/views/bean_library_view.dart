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
                    ? _EmptyLibraryView(
                        searchQuery: _viewModel.searchQuery,
                        bottomPadding: pageContentBottomPadding,// + 70.0,
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

class _EmptyLibraryView extends StatelessWidget {
  final String searchQuery;
  final double bottomPadding;

  const _EmptyLibraryView({
    required this.searchQuery,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget buildContent() {
      if (searchQuery.trim().isNotEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              SocoIcons.searchOff,
              size: AppSizes.icon.extraLarge2,
              color: colorScheme.outline.withValues(alpha: 0.5),
            ),
            AppSizes.gap.medium,
            Text(
              'No profiles matching your search',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.outline,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }

      final isDarkMode = Theme.of(context).brightness == Brightness.dark;
      final imagePath = isDarkMode
          ? 'assets/images/sleepy_coffee_dark.png'
          : 'assets/images/sleepy_coffee_light.png';

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radius.large),
            child: Image.asset(
              imagePath,
              width: 140,
              height: 140,
              fit: BoxFit.contain,
            ),
          ),
          AppSizes.gap.medium,
          Text(
            "No beans? That's depresso.\nAdd some and start brewing!",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.outline,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: (constraints.maxHeight - bottomPadding).clamp(0.0, double.infinity),
            ),
            child: Center(
              child: buildContent(),
            ),
          ),
        );
      },
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
          controller: scrollController,
          padding: EdgeInsets.only(
            left: AppSizes.spacing.medium,
            right: AppSizes.spacing.medium,
            top: AppSizes.spacing.medium, // Keep top padding matching the fade zone
            bottom: bottomPadding,
          ),
          itemCount: viewModel.brewProfiles.length,
          separatorBuilder: (context, index) => SizedBox(
            height: AppSizes.spacing.medium,
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
                      borderRadius: BorderRadius.circular(AppSizes.radius.large),
                    ),
                  ),
                ),
                // Swipeable Bean Card
                Dismissible(
                  key: Key(profile.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing.large),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.radius.large),
                    ),
                    child: Icon(
                      SocoIcons.deleteOutline,
                      color: colorScheme.onErrorContainer,
                      size: AppSizes.icon.extraLarge,
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
