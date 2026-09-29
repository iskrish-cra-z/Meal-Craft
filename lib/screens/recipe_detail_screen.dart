import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealcraft/models/ingredient.dart';
import 'package:mealcraft/models/recipe.dart';
import 'package:mealcraft/models/user_preferences.dart';
import 'package:mealcraft/services/app_state.dart';
import 'package:mealcraft/widgets/section_header.dart';
import 'package:mealcraft/widgets/primary_button.dart';
import 'package:mealcraft/screens/cooking_mode_screen.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  final MatchResult? matchResult;

  const RecipeDetailScreen({super.key, required this.recipe, this.matchResult});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppState>().addRecentlyViewed(widget.recipe.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isFavorite = appState.isFavorite(widget.recipe.id);
    
    Color bgColor = Colors.blueGrey;
    try {
      if (widget.recipe.imageColor.startsWith('#')) {
        bgColor = Color(int.parse(widget.recipe.imageColor.substring(1, 7), radix: 16) + 0xFF000000);
      }
    } catch (_) {}

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : null),
                onPressed: () => appState.toggleFavorite(widget.recipe.id),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.recipe.name, style: const TextStyle(color: Colors.white, shadows: [Shadow(color: Colors.black45, blurRadius: 4)])),
              background: Container(
                color: bgColor,
                alignment: Alignment.center,
                child: Text(
                  widget.recipe.imageEmoji,
                  style: const TextStyle(fontSize: 80),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.recipe.name, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(widget.recipe.description, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (widget.matchResult != null) ...[
                        Chip(
                          label: Text('${(widget.matchResult!.score * 100).toStringAsFixed(0)}% Match'),
                          backgroundColor: Colors.green.withOpacity(0.2),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Chip(
                        avatar: const Icon(Icons.timer, size: 16),
                        label: Text('${widget.recipe.cookingTime} min'),
                      ),
                      const SizedBox(width: 8),
                      Chip(label: Text(widget.recipe.difficulty.displayName)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(label: Text('${widget.recipe.servings} Servings')),
                      const SizedBox(width: 8),
                      Chip(label: Text(widget.recipe.dietaryType.displayName)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  if (widget.matchResult != null) ...[
                    Text('${widget.matchResult!.availableIngredients} of ${widget.matchResult!.totalIngredients} ingredients available', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                  ],

                  SectionHeader(title: 'Ingredients'),
                  ...widget.recipe.ingredients.map((ing) {
                    final hasIng = appState.pantry.any((pantryIng) => pantryIng.name.toLowerCase() == ing.name.toLowerCase());
                    return ListTile(
                      leading: Icon(hasIng ? Icons.check_circle : Icons.cancel, color: hasIng ? Colors.green : Colors.red),
                      title: Text(ing.name),
                      subtitle: Text('${ing.quantity} ${ing.unit.displayName}'),
                    );
                  }),
                  
                  const SizedBox(height: 24),
                  SectionHeader(title: 'Required Equipment'),
                  ...widget.recipe.requiredEquipment.map((eq) {
                    final hasEq = appState.selectedEquipment.contains(eq);
                    return ListTile(
                      leading: Icon(hasEq ? Icons.check_circle : Icons.cancel, color: hasEq ? Colors.green : Colors.red),
                      title: Text(eq),
                    );
                  }),

                  const SizedBox(height: 24),
                  SectionHeader(title: 'Nutrition per Serving'),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildNutritionCard('Calories', '${widget.recipe.nutrition.calories} kcal'),
                        _buildNutritionCard('Protein', '${widget.recipe.nutrition.protein}g'),
                        _buildNutritionCard('Carbs', '${widget.recipe.nutrition.carbs}g'),
                        _buildNutritionCard('Fat', '${widget.recipe.nutrition.fat}g'),
                        _buildNutritionCard('Fiber', '${widget.recipe.nutrition.fiber}g'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  SectionHeader(title: 'Instructions'),
                  ...widget.recipe.instructions.asMap().entries.map((entry) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(child: Text('${entry.key + 1}')),
                            const SizedBox(width: 12),
                            Expanded(child: Text(entry.value, style: const TextStyle(fontSize: 16))),
                          ],
                        ),
                      ),
                    );
                  }),
                  
                  const SizedBox(height: 32),
                  PrimaryButton(
                    label: 'Start Cooking',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CookingModeScreen(recipe: widget.recipe)),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(right: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
