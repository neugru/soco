import 'package:flutter/foundation.dart';
import '../models/coffee.dart';

class CoffeeLibraryViewModel extends ChangeNotifier {
  final List<Coffee> _allCoffees = [];
  List<Coffee> _filteredCoffees = [];
  bool _isLoading = false;
  String _searchQuery = '';

  // Getters
  bool get isLoading => _isLoading;
  List<Coffee> get coffees => _filteredCoffees;
  String get searchQuery => _searchQuery;

  /// Simulates fetching coffees from a repository or API
  Future<void> fetchCoffees() async {
    if (_allCoffees.isNotEmpty) return; // Prevent double loading if already loaded

    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Populate with mockup coffees matching the new Coffee model
    _allCoffees.addAll([
      const Coffee(
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
      const Coffee(
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
      const Coffee(
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
      const Coffee(
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

  /// Filters the coffee list based on the search query
  void search(String query) {
    _searchQuery = query;
    _applyFilterAndSort();
    notifyListeners();
  }

  /// Adds a new coffee to the library
  void addCoffee(Coffee coffee) {
    _allCoffees.add(coffee);
    _applyFilterAndSort();
    notifyListeners();
  }

  /// Removes a coffee from the library
  void removeCoffee(String id) {
    _allCoffees.removeWhere((c) => c.id == id);
    _applyFilterAndSort();
    notifyListeners();
  }

  /// Helper to filter and sort coffees based on search query
  void _applyFilterAndSort() {
    if (_searchQuery.trim().isEmpty) {
      _filteredCoffees = List.from(_allCoffees);
    } else {
      final query = _searchQuery.toLowerCase();
      _filteredCoffees = _allCoffees.where((coffee) {
        return coffee.name.toLowerCase().contains(query) ||
            coffee.brand.toLowerCase().contains(query) ||
            coffee.origin.toLowerCase().contains(query) ||
            coffee.grinder.toLowerCase().contains(query) ||
            coffee.machine.toLowerCase().contains(query) ||
            coffee.description.toLowerCase().contains(query);
      }).toList();
    }

    // Sort alphabetically by name
    _filteredCoffees.sort((a, b) => a.name.compareTo(b.name));
  }
}
