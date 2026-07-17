import 'package:flutter/material.dart';

import 'package:soco/core/models/brew_profile.dart';
import 'package:soco/ui/core/styles/assets.dart';
import 'package:soco/ui/core/styles/sizes.dart';
import 'package:soco/ui/core/styles/icons.dart';
import 'package:soco/ui/core/ui/widgets/empty_library_view.dart';
import 'package:soco/ui/core/ui/widgets/fading_mask.dart';
import 'package:soco/ui/core/ui/widgets/library_app_bar.dart';
import 'package:soco/ui/core/ui/widgets/library_search_bar.dart';
import 'package:soco/ui/core/ui/widgets/loading_view.dart';
import 'package:soco/ui/features/bean_library/viewmodels/bean_library_viewmodel.dart';
import 'package:soco/ui/features/bean_library/views/add_bean_dialog.dart';
import 'package:soco/ui/features/bean_library/views/widgets/bean_card.dart';

/// A screen that displays the list of coffee beans and their associated brew profiles.
///
/// Allows searching, filtering, expanding/collapsing card details, and multi-selection
/// mode for batch operations like deleting or sharing.
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
      barrierDismissible: false,
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
    final safeAreaBottom = MediaQuery.paddingOf(context).bottom;
    // page scroll should end with extra spacing above the bottom navBar
    final pageContentBottomPadding = safeAreaBottom + SocoSizes.spacing.medium;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const LibraryAppBar(
            title: 'Bean Library',
            icon: SocoIcons.coffeeBean,
          ),
          body: _viewModel.isLoading
              // TODO: replace with skeleton
              ? LoadingView(
                  message: 'Loading beans...',
                  bottomPadding: safeAreaBottom,
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SocoSizes.spacing.medium,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
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
                      if (_viewModel.isSelectionMode)
                        _SelectionActionBar(
                          selectedCount: _viewModel.selectedCount,
                          onClear: () => _viewModel.exitSelectionMode(),
                          onShare: () {
                            final selectedCount = _viewModel.selectedCount;
                            if (selectedCount == 0) return;
                            final names = _viewModel.getSelectedBeansNamesString();

                            // TODO: Implement real sharing functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Sharing $selectedCount bean(s): $names'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            _viewModel.exitSelectionMode();
                          },
                          onDelete: () {
                            final selectedCount = _viewModel.selectedCount;
                            if (selectedCount == 0) return;

                            // Store deleted profiles for Undo
                            final deletedProfiles = _viewModel.brewProfiles
                                .where((p) => _viewModel.selectedProfileIds.contains(p.id))
                                .toList();

                            _viewModel.deleteSelected();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Removed $selectedCount bean(s)'),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 4),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    for (final profile in deletedProfiles) {
                                      _viewModel.addBrewProfile(profile);
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      else
                        _UtilityHeaderBar(
                          isExpanded: _isExpanded,
                          onExpandedChanged: (val) {
                            setState(() {
                              _isExpanded = val;
                            });
                          },
                          onAddPressed: _showAddBeanDialog,
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
                  ),
                ),
        );
      },
    );
  }
}

/// Renders a scrollable list of brew profiles wrapped in a fading mask.
class _BeanProfileList extends StatelessWidget {
  /// The active view model instance handling business state.
  final BeanLibraryViewModel viewModel;

  /// The scroll controller linked to the scrollbar and list.
  final ScrollController scrollController;

  /// Whether bean cards should display expanded recipe metrics.
  final bool isExpanded;

  /// Extra padding applied at the bottom of the list to prevent floating elements overlapping.
  final double bottomPadding;

  const _BeanProfileList({
    required this.viewModel,
    required this.scrollController,
    required this.isExpanded,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    final topFadeZoneHeight = SocoSizes.spacing.medium;

    return Scrollbar(
      controller: scrollController,
      child: FadingMask(
        fadeHeightTop: topFadeZoneHeight,
        child: ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.only(
            // Keep top padding matching the fade zone, so the list is not faded in default position
            top: topFadeZoneHeight,
            bottom: bottomPadding,
          ),
          itemCount: viewModel.brewProfiles.length,
          separatorBuilder: (context, index) => SizedBox(
            height: SocoSizes.spacing.medium,
          ),
          itemBuilder: (context, index) {
            final profile = viewModel.brewProfiles[index];
            final isSelected = viewModel.selectedProfileIds.contains(profile.id);

            return BeanCard(
              profile: profile,
              isExpanded: isExpanded,
              isSelectionMode: viewModel.isSelectionMode,
              isSelected: isSelected,
              onTap: () {
                if (viewModel.isSelectionMode) {
                  viewModel.toggleSelection(profile.id);
                }
              },
              onLongPress: () {
                if (!viewModel.isSelectionMode) {
                  viewModel.enterSelectionMode(profile.id);
                }
              },
              onSelect: () {
                viewModel.enterSelectionMode(profile.id);
              },
              onShare: () {
                // TODO: Implement real sharing functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sharing profile for ${profile.bean.name}...'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              onDelete: () {
                viewModel.removeBrewProfiles([profile.id]);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${profile.bean.name} removed'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 4),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () => viewModel.addBrewProfile(profile),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// An inline action bar displayed at the top of the bean list when in selection mode.
///
/// Provides control actions to cancel selection, view the selected count, and execute
/// batch actions such as share or delete on the selected profiles.
class _SelectionActionBar extends StatelessWidget {
  /// The number of currently selected profiles.
  final int selectedCount;

  /// Callback triggered when the clear/cancel selection action is pressed.
  final VoidCallback onClear;

  /// Callback triggered when the batch share action is pressed.
  final VoidCallback onShare;

  /// Callback triggered when the batch delete action is pressed.
  final VoidCallback onDelete;

  const _SelectionActionBar({
    required this.selectedCount,
    required this.onClear,
    required this.onShare,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SocoSizes.spacing.extraSmall,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(SocoSizes.radius.medium),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              SocoIcons.clear,
              size: SocoSizes.icon.medium,
            ),
            onPressed: onClear,
          ),
          SocoSizes.gap.horizontal.small,
          Text(
            '$selectedCount Selected',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  SocoIcons.share,
                  size: SocoSizes.icon.medium,
                ),
                onPressed: onShare,
              ),
              IconButton(
                icon: Icon(
                  SocoIcons.deleteOutline,
                  size: SocoSizes.icon.medium,
                  color: colorScheme.error,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A control bar displayed above the bean list providing utility controls.
///
/// Contains a switch to toggle expanded card views, and a primary action button
/// to add a new bean profile.
class _UtilityHeaderBar extends StatelessWidget {
  /// Whether the cards in the list should display expanded recipe metrics.
  final bool isExpanded;

  /// Callback triggered when the expanded card view state toggle switch changes.
  final ValueChanged<bool> onExpandedChanged;

  /// Callback triggered when the "New" button is pressed to create a profile.
  final VoidCallback onAddPressed;

  const _UtilityHeaderBar({
    required this.isExpanded,
    required this.onExpandedChanged,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Expanded Cards',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: isExpanded,
              onChanged: onExpandedChanged,
            ),
          ],
        ),
        FilledButton.icon(
          onPressed: onAddPressed,
          icon: Icon(
            SocoIcons.add,
            size: SocoSizes.icon.small,
          ),
          label: const Text('New'),
        ),
      ],
    );
  }
}
