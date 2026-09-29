import 'package:mealcraft/models/ingredient.dart';
import 'package:mealcraft/models/recipe.dart';
import 'package:mealcraft/models/user_preferences.dart';

class RecipeMatcher {
  static List<MatchResult> findMatches({
    required List<Recipe> recipes,
    required List<Ingredient> userIngredients,
    required Set<String> userEquipment,
    required UserPreferences preferences,
  }) {
    List<MatchResult> results = [];

    for (var recipe in recipes) {
      int rawScore = 0;
      int availableIngredients = 0;
      int availableEquipment = 0;
      List<String> missingIngredients = [];
      List<String> missingEquipment = [];
      
      int totalRequiredIngredients = 0;
      for (var requiredIngredient in recipe.ingredients) {
        if (!requiredIngredient.isOptional) {
          totalRequiredIngredients++;
          bool hasIngredient = false;
          bool hasSufficient = false;

          for (var userIngredient in userIngredients) {
            if (userIngredient.name.toLowerCase() == requiredIngredient.name.toLowerCase()) {
              hasIngredient = true;
              if (userIngredient.quantity >= requiredIngredient.quantity) { // Assume same unit for simplicity
                hasSufficient = true;
              }
              break;
            }
          }

          if (hasIngredient && hasSufficient) {
            rawScore += 10;
            availableIngredients++;
          } else if (hasIngredient && !hasSufficient) {
            rawScore += 5;
            availableIngredients++;
          } else {
            rawScore -= 10;
            missingIngredients.add(requiredIngredient.name);
          }
        }
      }

      int totalRequiredEquipment = recipe.requiredEquipment.length;
      for (var equip in recipe.requiredEquipment) {
        if (userEquipment.contains(equip)) {
          rawScore += 15;
          availableEquipment++;
        } else {
          rawScore -= 20;
          missingEquipment.add(equip);
        }
      }

      if (preferences.mealType != MealType.any && preferences.mealType == recipe.mealType) {
        rawScore += 10;
      }
      if (preferences.dietaryType != DietaryType.any && preferences.dietaryType == recipe.dietaryType) {
        rawScore += 15;
      }
      if (preferences.spiceLevel == recipe.spiceLevel) {
        rawScore += 5;
      }
      if (preferences.difficulty == recipe.difficulty) {
        rawScore += 5;
      }
      if (preferences.maxCookingTime != null && recipe.cookingTime <= preferences.maxCookingTime!) {
        rawScore += 10;
      }

      int maxPossible = (totalRequiredIngredients * 10) + (totalRequiredEquipment * 15) + 45;
      
      double score = 0.0;
      if (maxPossible > 0) {
          score = (rawScore / maxPossible) * 100.0;
      } else {
          score = rawScore > 0 ? 100.0 : 0.0;
      }
      score = score.clamp(0.0, 100.0);

      results.add(MatchResult(
        recipe: recipe,
        score: score,
        availableIngredients: availableIngredients,
        totalIngredients: totalRequiredIngredients,
        availableEquipment: availableEquipment,
        totalEquipment: totalRequiredEquipment,
        missingIngredients: missingIngredients,
        missingEquipment: missingEquipment,
      ));
    }

    results.sort((a, b) => b.score.compareTo(a.score));
    return results;
  }
}
