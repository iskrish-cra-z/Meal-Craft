import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealcraft/models/recipe.dart';
import 'package:mealcraft/models/user_preferences.dart';
import 'package:mealcraft/data/recipe_data.dart';
import 'package:mealcraft/services/app_state.dart';
import 'package:mealcraft/widgets/recipe_card.dart';
import 'package:mealcraft/widgets/section_header.dart';
import 'package:mealcraft/widgets/empty_state.dart';
import 'package:mealcraft/screens/recipe_detail_screen.dart';

class RecipesScreen extends StatefulWidget {
  final bool showFavoritesFirst;

  const RecipesScreen({super.key, this.showFavoritesFirst = false});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'All';
  bool _isGridView = false;

  final List<String> _filters = [
    'All', 'Vegetarian', 'Non-Veg', 'Vegan', 
    'Breakfast', 'Lunch', 'Dinner', 'Snack', 'Dessert',
    'Under 30 min', 'Easy', 'Spicy'
  ];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    
    List<Recipe> filteredRecipes = RecipeData.allRecipes.where((recipe) {
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchText = recipe.name.toLowerCase().contains(query) || 
                          recipe.description.toLowerCase().contains(query) ||
                          recipe.tags.any((tag) => tag.toLowerCase().contains(query));
        if (!matchText) return false;
      }
      
      switch (_selectedFilter) {
        case 'Vegetarian':
          if (recipe.dietaryType != DietaryType.vegetarian) return false;
          break;
        case 'Non-Veg':
          if (recipe.dietaryType != DietaryType.nonVegetarian) return false;
          break;
        case 'Vegan':
          if (recipe.dietaryType != DietaryType.vegan) return false;
          break;
        case 'Breakfast':
          if (recipe.mealType != MealType.breakfast) return false;
          break;
        case 'Lunch':
          if (recipe.mealType != MealType.lunch) return false;
          break;
        case 'Dinner':
          if (recipe.mealType != MealType.dinner) return false;
          break;
        case 'Snack':
          if (recipe.mealType != MealType.snack) return false;
          break;
        case 'Dessert':
          if (recipe.mealType != MealType.dessert) return false;
          break;
        case 'Under 30 min':
          if (recipe.cookingTime >= 30) return false;
          break;
        case 'Easy':
          if (recipe.difficulty != Difficulty.easy) return false;
          break;
        case 'Spicy':
          if (recipe.spiceLevel != SpiceLevel.spicy) return false;
          break;
      }
      return true;
    }).toList();

    final favoriteRecipes = filteredRecipes.where((r) => appState.isFavorite(r.id)).toList();
    if (widget.showFavoritesFirst) {
      filteredRecipes.removeWhere((r) => appState.isFavorite(r.id));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Recipes'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              hintText: 'Search recipes...',
              leading: const Icon(Icons.search),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: _filters.map((filter) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: _selectedFilter == filter,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedFilter = filter);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredRecipes.isEmpty && favoriteRecipes.isEmpty
                ? Center(
                    child: EmptyState(
                      icon: Icons.search_off,
                      title: 'No recipes found',
                      subtitle: 'Try adjusting your filters or search query.',
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (widget.showFavoritesFirst && favoriteRecipes.isNotEmpty) ...[
                        SectionHeader(title: 'Your Favorites'),
                        _buildRecipeList(favoriteRecipes, appState),
                        const SizedBox(height: 24),
                        SectionHeader(title: 'Other Recipes'),
                      ],
                      _buildRecipeList(filteredRecipes, appState),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeList(List<Recipe> recipes, AppState appState) {
    if (_isGridView) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: recipes.length,
        itemBuilder: (context, index) => _buildRecipeItem(recipes[index], appState),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recipes.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _buildRecipeItem(recipes[index], appState),
      ),
    );
  }

  Widget _buildRecipeItem(Recipe recipe, AppState appState) {
    return RecipeCard(
      recipe: recipe,
      isFavorite: appState.isFavorite(recipe.id),
      onFavoriteToggle: () => appState.toggleFavorite(recipe.id),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipe: recipe)),
        );
      },
    );
  }
}
