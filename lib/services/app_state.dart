import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:mealcraft/models/ingredient.dart';
import 'package:mealcraft/models/user_preferences.dart';
import 'package:mealcraft/services/favorites_service.dart';

class AppState extends ChangeNotifier {
  final List<Ingredient> _pantry = [
    Ingredient(name: 'Egg', quantity: 6, unit: IngredientUnit.pieces),
    Ingredient(name: 'Rice', quantity: 500, unit: IngredientUnit.grams),
    Ingredient(name: 'Onion', quantity: 4, unit: IngredientUnit.pieces),
    Ingredient(name: 'Tomato', quantity: 3, unit: IngredientUnit.pieces),
    Ingredient(name: 'Oil', quantity: 500, unit: IngredientUnit.ml),
    Ingredient(name: 'Salt', quantity: 100, unit: IngredientUnit.grams),
    Ingredient(name: 'Garlic', quantity: 10, unit: IngredientUnit.cloves),
    Ingredient(name: 'Bread', quantity: 8, unit: IngredientUnit.slices),
    Ingredient(name: 'Milk', quantity: 500, unit: IngredientUnit.ml),
    Ingredient(name: 'Butter', quantity: 100, unit: IngredientUnit.grams),
  ];

  Set<String> _selectedEquipment = {'Gas Stove', 'Pan', 'Pot'};
  UserPreferences _preferences = UserPreferences();
  Set<String> _favoriteIds = {};
  final List<String> _recentlyViewedIds = [];
  bool _isDarkMode = false;

  UnmodifiableListView<Ingredient> get pantry => UnmodifiableListView(_pantry);
  UnmodifiableSetView<String> get selectedEquipment => UnmodifiableSetView(_selectedEquipment);
  UserPreferences get preferences => _preferences;
  UnmodifiableSetView<String> get favoriteIds => UnmodifiableSetView(_favoriteIds);
  UnmodifiableListView<String> get recentlyViewedIds => UnmodifiableListView(_recentlyViewedIds);
  bool get isDarkMode => _isDarkMode;

  Future<void> init() async {
    _favoriteIds = await FavoritesService.loadFavorites();
    notifyListeners();
  }

  void addIngredient(Ingredient ingredient) {
    _pantry.add(ingredient);
    notifyListeners();
  }

  void removeIngredient(int index) {
    if (index >= 0 && index < _pantry.length) {
      _pantry.removeAt(index);
      notifyListeners();
    }
  }

  void updateIngredient(int index, Ingredient ingredient) {
    if (index >= 0 && index < _pantry.length) {
      _pantry[index] = ingredient;
      notifyListeners();
    }
  }

  void toggleEquipment(String equipment) {
    if (_selectedEquipment.contains(equipment)) {
      _selectedEquipment.remove(equipment);
    } else {
      _selectedEquipment.add(equipment);
    }
    notifyListeners();
  }

  void clearEquipment() {
    _selectedEquipment.clear();
    notifyListeners();
  }

  void setEquipment(Set<String> equipment) {
    _selectedEquipment = Set.from(equipment);
    notifyListeners();
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    FavoritesService.saveFavorites(_favoriteIds);
    notifyListeners();
  }

  void clearFavorites() {
    _favoriteIds.clear();
    FavoritesService.saveFavorites(_favoriteIds);
    notifyListeners();
  }

  void addRecentlyViewed(String id) {
    _recentlyViewedIds.remove(id);
    _recentlyViewedIds.insert(0, id);
    if (_recentlyViewedIds.length > 10) {
      _recentlyViewedIds.removeLast();
    }
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void updatePreferences(UserPreferences preferences) {
    _preferences = preferences;
    notifyListeners();
  }

  void resetPreferences() {
    _preferences = UserPreferences();
    notifyListeners();
  }
}
