import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealcraft/models/recipe.dart';
import 'package:mealcraft/services/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 48),
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            Text('Your Kitchen', style: Theme.of(context).textTheme.headlineMedium),
            const Text('Turn what you have into something delicious.'),
            const SizedBox(height: 32),

            _buildSectionHeader(context, 'PREFERENCES'),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text('Default Diet'),
              subtitle: Text(appState.preferences.dietaryType.displayName),
              onTap: () => _showDietDialog(context, appState),
            ),
            ListTile(
              leading: const Icon(Icons.local_fire_department),
              title: const Text('Default Spice Level'),
              subtitle: Text(appState.preferences.spiceLevel.displayName),
              onTap: () => _showSpiceDialog(context, appState),
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Default Cooking Time'),
              subtitle: Text(appState.preferences.maxCookingTime != null ? '${appState.preferences.maxCookingTime} min' : 'Any'),
            ),

            const SizedBox(height: 16),
            _buildSectionHeader(context, 'SETTINGS'),
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              value: appState.isDarkMode,
              onChanged: (val) => appState.toggleDarkMode(),
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Reset Preferences'),
              onTap: () => _confirmReset(context, appState),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Clear Favorites', style: TextStyle(color: Colors.red)),
              onTap: () => _confirmClearFavorites(context, appState),
            ),

            const SizedBox(height: 32),
            const Text('🍳', style: TextStyle(fontSize: 40)),
            const SizedBox(height: 8),
            Text('MealCraft', style: Theme.of(context).textTheme.titleLarge),
            const Text('Turn what you have into something delicious.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            const Text('Version 1.0', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 8),
            const Text('Made with ❤️ for home cooks', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  void _showDietDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Diet'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: DietaryType.values.map((type) {
            return RadioListTile<DietaryType>(
              title: Text(type.displayName),
              value: type,
              groupValue: appState.preferences.dietaryType,
              onChanged: (val) {
                if (val != null) {
                  appState.updatePreferences(appState.preferences.copyWith(dietaryType: val));
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showSpiceDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Spice Level'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: SpiceLevel.values.map((level) {
            return RadioListTile<SpiceLevel>(
              title: Text(level.displayName),
              value: level,
              groupValue: appState.preferences.spiceLevel,
              onChanged: (val) {
                if (val != null) {
                  appState.updatePreferences(appState.preferences.copyWith(spiceLevel: val));
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Preferences?'),
        content: const Text('This will reset all your dietary and cooking preferences.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              appState.resetPreferences();
              Navigator.pop(context);
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _confirmClearFavorites(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Favorites?'),
        content: const Text('This will remove all recipes from your favorites list.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              appState.clearFavorites();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
