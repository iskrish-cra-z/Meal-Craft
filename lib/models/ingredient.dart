enum IngredientUnit {
  pieces,
  grams,
  ml,
  cups,
  tablespoons,
  teaspoons,
  slices,
  cloves,
  bunch,
  pinch,
}

extension IngredientUnitExtension on IngredientUnit {
  String get displayName {
    switch (this) {
      case IngredientUnit.pieces:
        return 'pcs';
      case IngredientUnit.grams:
        return 'g';
      case IngredientUnit.ml:
        return 'ml';
      case IngredientUnit.cups:
        return 'cups';
      case IngredientUnit.tablespoons:
        return 'tbsp';
      case IngredientUnit.teaspoons:
        return 'tsp';
      case IngredientUnit.slices:
        return 'slices';
      case IngredientUnit.cloves:
        return 'cloves';
      case IngredientUnit.bunch:
        return 'bunch';
      case IngredientUnit.pinch:
        return 'pinch';
    }
  }

  String get fullName {
    switch (this) {
      case IngredientUnit.pieces:
        return 'Pieces';
      case IngredientUnit.grams:
        return 'Grams';
      case IngredientUnit.ml:
        return 'Milliliters';
      case IngredientUnit.cups:
        return 'Cups';
      case IngredientUnit.tablespoons:
        return 'Tablespoons';
      case IngredientUnit.teaspoons:
        return 'Teaspoons';
      case IngredientUnit.slices:
        return 'Slices';
      case IngredientUnit.cloves:
        return 'Cloves';
      case IngredientUnit.bunch:
        return 'Bunch';
      case IngredientUnit.pinch:
        return 'Pinch';
    }
  }
}

class Ingredient {
  String name;
  double quantity;
  IngredientUnit unit;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Ingredient copyWith({
    String? name,
    double? quantity,
    IngredientUnit? unit,
  }) {
    return Ingredient(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }
}
