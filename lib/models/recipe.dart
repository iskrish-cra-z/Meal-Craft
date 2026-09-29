import 'package:mealcraft/models/ingredient.dart';

enum Difficulty {
  easy,
  medium,
  advanced,
}

extension DifficultyExtension on Difficulty {
  String get displayName {
    switch (this) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.advanced:
        return 'Advanced';
    }
  }
}

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
  dessert,
  any,
}

extension MealTypeExtension on MealType {
  String get displayName {
    switch (this) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snack:
        return 'Snack';
      case MealType.dessert:
        return 'Dessert';
      case MealType.any:
        return 'Any';
    }
  }
}

enum DietaryType {
  vegetarian,
  nonVegetarian,
  vegan,
  any,
}

extension DietaryTypeExtension on DietaryType {
  String get displayName {
    switch (this) {
      case DietaryType.vegetarian:
        return 'Vegetarian';
      case DietaryType.nonVegetarian:
        return 'Non-Vegetarian';
      case DietaryType.vegan:
        return 'Vegan';
      case DietaryType.any:
        return 'Any';
    }
  }
}

enum SpiceLevel {
  mild,
  medium,
  spicy,
}

extension SpiceLevelExtension on SpiceLevel {
  String get displayName {
    switch (this) {
      case SpiceLevel.mild:
        return 'Mild';
      case SpiceLevel.medium:
        return 'Medium';
      case SpiceLevel.spicy:
        return 'Spicy';
    }
  }
}

class RecipeIngredient {
  final String name;
  final double quantity;
  final IngredientUnit unit;
  final bool isOptional;

  const RecipeIngredient({
    required this.name,
    required this.quantity,
    required this.unit,
    this.isOptional = false,
  });
}

class Nutrition {
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;

  const Nutrition({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
  });
}

class Recipe {
  final String id;
  final String name;
  final String description;
  final List<RecipeIngredient> ingredients;
  final List<String> requiredEquipment;
  final int cookingTime;
  final Difficulty difficulty;
  final MealType mealType;
  final DietaryType dietaryType;
  final SpiceLevel spiceLevel;
  final List<String> instructions;
  final String imageEmoji;
  final String imageColor;
  final Nutrition nutrition;
  final List<String> tags;
  final int servings;

  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.requiredEquipment,
    required this.cookingTime,
    required this.difficulty,
    required this.mealType,
    required this.dietaryType,
    required this.spiceLevel,
    required this.instructions,
    required this.imageEmoji,
    required this.imageColor,
    required this.nutrition,
    required this.tags,
    required this.servings,
  });
}
