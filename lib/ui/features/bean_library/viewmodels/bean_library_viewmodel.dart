import 'package:flutter/foundation.dart';

import 'package:soco/core/models/bean.dart';
import 'package:soco/core/models/brew_profile.dart';
import 'package:soco/core/models/grinder.dart';
import 'package:soco/core/models/machine.dart';
import 'package:soco/core/models/roast_level.dart';

class BeanLibraryViewModel extends ChangeNotifier {
  final List<BrewProfile> _allBrewProfiles = [];
  List<BrewProfile> _filteredBrewProfiles = [];
  bool _isLoading = false;
  String _searchQuery = '';

  // Getters
  bool get isLoading => _isLoading;
  List<BrewProfile> get brewProfiles => _filteredBrewProfiles;
  String get searchQuery => _searchQuery;

  // Track if VM is disposed to prevent notifyListeners() crashes
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  /// Simulates fetching recipes from a repository or API
  Future<void> fetchBeans({bool forceRefresh = false}) async {
    // Prevent double loading if a fetch is already in progress
    if (_isLoading) return;

    // Skip if already loaded and refresh is not forced
    if (_allBrewProfiles.isNotEmpty && !forceRefresh) return;

    _isLoading = true;
    if (!_isDisposed) notifyListeners();

    try {
      // Simulate network delay
      // TODO: implement real data fetching
      // await Future.delayed(const Duration(milliseconds: 1000));

      // Clear existing records to avoid duplicating list items on reload
      _allBrewProfiles.clear();

      // Populate with mockup recipes matching the new BrewProfile model
      _allBrewProfiles.addAll([
        const BrewProfile(
          id: '1',
          bean: Bean(
            id: 'b1',
            name: 'Ethiopia Yirgacheffe',
            brand: 'Sey Coffee',
            origin: 'Ethiopia (Single Origin)',
            roastLevel: RoastLevel.light,
            strength: 2,
          ),
          machine: Machine(id: 'm1', brand: 'La Marzocco', name: 'Linea Micra'),
          grinder: Grinder(id: 'g1', brand: 'Comandante', name: 'C40'),
          dose: 18.0,
          grindSize: 12.50,
          brewYield: 42.0,
          brewTimeSeconds: 28,
          description: 'Floral jasmine aroma with bright bergamot acidity and peach sweetness. High clarity.',
          rating: 4.9,
        ),
        const BrewProfile(
          id: '2',
          bean: Bean(
            id: 'b2',
            name: 'Bella Vista Bourbon',
            brand: 'Intelligentsia',
            origin: 'Guatemala',
            roastLevel: RoastLevel.medium,
            strength: 3,
          ),
          machine: Machine(id: 'm2', brand: 'Sage', name: 'Barista Express'),
          grinder: Grinder(id: 'g2', brand: 'Fellow', name: 'Ode Gen 2'),
          dose: 18.0,
          grindSize: 14.20,
          brewYield: 36.0,
          brewTimeSeconds: 30,
          description: 'Smooth honey processing yields tasting notes of red apple, sweet plum, and rich caramel.',
          rating: 4.7,
        ),
        const BrewProfile(
          id: '3',
          bean: Bean(
            id: 'b3',
            name: 'Three Mules Blend',
            brand: 'Blue Bottle',
            origin: 'Colombia & Sumatra',
            roastLevel: RoastLevel.dark,
            strength: 5,
          ),
          machine: Machine(id: 'm3', brand: 'Slayer', name: 'Espresso Single Group'),
          grinder: Grinder(id: 'g3', brand: 'Mahlkönig', name: 'EK43'),
          dose: 20.0,
          grindSize: 18.00,
          brewYield: 40.0,
          brewTimeSeconds: 32,
          description: 'Heavy body with robust notes of dark chocolate, peat moss, toasted marshmallow, and spice.',
          rating: 4.5,
        ),
        const BrewProfile(
          id: '4',
          bean: Bean(
            id: 'b4',
            name: 'Pacamara Natural',
            brand: 'Onyx Coffee Lab',
            origin: 'El Salvador',
            roastLevel: RoastLevel.light,
            strength: 2,
          ),
          machine: Machine(id: 'm4', brand: 'Decent', name: 'DE1PRO'),
          grinder: Grinder(id: 'g4', brand: 'Lagom', name: 'P64'),
          dose: 19.0,
          grindSize: 11.55,
          brewYield: 45.0,
          brewTimeSeconds: 27,
          description: 'Complex tropical fruit acidity, dried mango, red wine notes, and a velvety chocolate finish.',
          rating: 4.8,
        ),
      ]);

      _applyFilterAndSort();
    } finally {
      _isLoading = false;
      if (!_isDisposed) notifyListeners();
    }
  }

  /// Filters the recipe list based on the search query
  void search(String query) {
    _searchQuery = query;
    _applyFilterAndSort();
    notifyListeners();
  }

  /// Adds a new recipe to the library
  void addBrewProfile(BrewProfile profile) {
    _allBrewProfiles.add(profile);
    _applyFilterAndSort();
    notifyListeners();
  }

  /// Removes a recipe from the library
  void removeBrewProfile(String id) {
    _allBrewProfiles.removeWhere((p) => p.id == id);
    _applyFilterAndSort();
    notifyListeners();
  }

  /// Helper to filter and sort recipes based on search query
  void _applyFilterAndSort() {
    if (_searchQuery.trim().isEmpty) {
      _filteredBrewProfiles = List.from(_allBrewProfiles);
    } else {
      final query = _searchQuery.toLowerCase();
      _filteredBrewProfiles = _allBrewProfiles.where((profile) {
        return profile.bean.name.toLowerCase().contains(query) ||
            profile.bean.brand.toLowerCase().contains(query) ||
            profile.bean.origin.toLowerCase().contains(query) ||
            profile.grinder.displayName.toLowerCase().contains(query) ||
            profile.machine.displayName.toLowerCase().contains(query) ||
            profile.description.toLowerCase().contains(query);
      }).toList();
    }

    // Sort alphabetically by bean name
    _filteredBrewProfiles.sort((a, b) => a.bean.name.compareTo(b.bean.name));
  }
}
