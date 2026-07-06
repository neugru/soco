import 'package:flutter/foundation.dart';

import 'package:soco/ui/features/bean_library/models/bean.dart';

class BeanLibraryViewModel extends ChangeNotifier {
  final List<Bean> _allBeans = [];
  List<Bean> _filteredBeans = [];
  bool _isLoading = false;
  String _searchQuery = '';

  // Getters
  bool get isLoading => _isLoading;
  List<Bean> get beans => _filteredBeans;
  String get searchQuery => _searchQuery;

  /// Simulates fetching beans from a repository or API
  Future<void> fetchBeans() async {
    if (_allBeans.isNotEmpty) return; // Prevent double loading if already loaded

    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    // await Future.delayed(const Duration(milliseconds: 1000));

    // Populate with mockup beans matching the new Bean model
    _allBeans.addAll([
      const Bean(
        id: '1',
        name: 'Ethiopia Yirgacheffe',
        brand: 'Sey Coffee',
        grindSize: 12.50,
        origin: 'Ethiopia (Single Origin)',
        roastLevel: RoastLevel.light,
        description: 'Floral jasmine aroma with bright bergamot acidity and peach sweetness. High clarity.',
        rating: 4.9,
        grinder: 'Comandante C40',
        machine: 'La Marzocco Linea Micra',
      ),
      const Bean(
        id: '2',
        name: 'Bella Vista Bourbon',
        brand: 'Intelligentsia',
        grindSize: 14.20,
        origin: 'Guatemala',
        roastLevel: RoastLevel.medium,
        description: 'Smooth honey processing yields tasting notes of red apple, sweet plum, and rich caramel.',
        rating: 4.7,
        grinder: 'Fellow Ode Gen 2',
        machine: 'Sage Barista Express',
      ),
      const Bean(
        id: '3',
        name: 'Three Mules Blend',
        brand: 'Blue Bottle',
        grindSize: 18.00,
        origin: 'Colombia & Sumatra',
        roastLevel: RoastLevel.dark,
        description: 'Heavy body with robust notes of dark chocolate, peat moss, toasted marshmallow, and spice.',
        rating: 4.5,
        grinder: 'Mahlkönig EK43',
        machine: 'Slayer Espresso Single Group',
      ),
      const Bean(
        id: '4',
        name: 'Pacamara Natural',
        brand: 'Onyx Coffee Lab',
        grindSize: 11.55,
        origin: 'El Salvador',
        roastLevel: RoastLevel.light,
        description: 'Complex tropical fruit acidity, dried mango, red wine notes, and a velvety chocolate finish.',
        rating: 4.8,
        grinder: 'Lagom P64',
        machine: 'Decent DE1PRO',
      ),
    ]);

    _applyFilterAndSort();
    _isLoading = false;
    notifyListeners();
  }

  /// Filters the bean list based on the search query
  void search(String query) {
    _searchQuery = query;
    _applyFilterAndSort();
    notifyListeners();
  }

  /// Adds a new bean to the library
  void addBean(Bean bean) {
    _allBeans.add(bean);
    _applyFilterAndSort();
    notifyListeners();
  }

  /// Removes a bean from the library
  void removeBean(String id) {
    _allBeans.removeWhere((b) => b.id == id);
    _applyFilterAndSort();
    notifyListeners();
  }

  /// Helper to filter and sort beans based on search query
  void _applyFilterAndSort() {
    if (_searchQuery.trim().isEmpty) {
      _filteredBeans = List.from(_allBeans);
    } else {
      final query = _searchQuery.toLowerCase();
      _filteredBeans = _allBeans.where((bean) {
        return bean.name.toLowerCase().contains(query) ||
            bean.brand.toLowerCase().contains(query) ||
            bean.origin.toLowerCase().contains(query) ||
            bean.grinder.toLowerCase().contains(query) ||
            bean.machine.toLowerCase().contains(query) ||
            bean.description.toLowerCase().contains(query);
      }).toList();
    }

    // Sort alphabetically by name
    _filteredBeans.sort((a, b) => a.name.compareTo(b.name));
  }
}
