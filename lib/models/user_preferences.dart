import 'package:mealcraft/models/recipe.dart';

class UserPreferences {
  MealType mealType;
  int? maxCookingTime;
  DietaryType dietaryType;
  SpiceLevel spiceLevel;
  Difficulty difficulty;

  UserPreferences({
    this.mealType = MealType.any,
    this.maxCookingTime,
    this.dietaryType = DietaryType.any,
    this.spiceLevel = SpiceLevel.medium,
    this.difficulty = Difficulty.easy,
  });

  UserPreferences copyWith({
    MealType? mealType,
    int? maxCookingTime,
    bool clearMaxCookingTime = false,
    DietaryType? dietaryType,
    SpiceLevel? spiceLevel,
    Difficulty? difficulty,
  }) {
    return UserPreferences(
      mealType: mealType ?? this.mealType,
      maxCookingTime: clearMaxCookingTime ? null : (maxCookingTime ?? this.maxCookingTime),
      dietaryType: dietaryType ?? this.dietaryType,
      spiceLevel: spiceLevel ?? this.spiceLevel,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}

class MatchResult {
  final Recipe recipe;
  final double score;
  final int availableIngredients;
  final int totalIngredients;
  final int availableEquipment;
  final int totalEquipment;
  final List<String> missingIngredients;
  final List<String> missingEquipment;

  const MatchResult({
    required this.recipe,
    required this.score,
    required this.availableIngredients,
    required this.totalIngredients,
    required this.availableEquipment,
    required this.totalEquipment,
    required this.missingIngredients,
    required this.missingEquipment,
  });
}
