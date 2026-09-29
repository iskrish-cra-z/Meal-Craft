import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';

class PantryModule extends StatelessWidget {
  const PantryModule({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    
    // Provide fallback if pantry is not yet fully implemented
    final List<dynamic> pantry = _getPantry(appState);

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Your Ingredients',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Badge(
                  label: Text('${pantry.length}'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add an ingredient...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        try {
                          (appState as dynamic).addIngredient(value);
                        } catch (e) {
                          debugPrint('Error adding ingredient: $e');
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: () {
                    try {
                      (appState as dynamic).addIngredient('New Ingredient');
                    } catch (e) {
                      debugPrint('Error adding ingredient: $e');
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: pantry.map<Widget>((ingredient) {
                String name = ingredient.toString();
                try {
                  name = ingredient.name;
                  if (ingredient.unit != null && ingredient.unit.toString().isNotEmpty) {
                    name += ' (${ingredient.unit})';
                  }
                } catch (_) {}

                return Chip(
                  label: Text(name),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none,
                  ),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  onDeleted: () {
                    try {
                      (appState as dynamic).removeIngredient(ingredient);
                    } catch (e) {
                      debugPrint('Error removing ingredient: $e');
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                border: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
              ),
              child: SwitchListTile(
                title: const Text('Kitchen Staples Assumed'),
                subtitle: const Text('Salt, pepper, oil, etc.'),
                value: _getAssumeStaples(appState),
                onChanged: (value) {
                  try {
                    (appState as dynamic).setAssumeStaples(value);
                  } catch (e) {
                    debugPrint('Error setting staples: $e');
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<dynamic> _getPantry(AppState appState) {
    try {
      return (appState as dynamic).pantry ?? [];
    } catch (e) {
      return [];
    }
  }

  bool _getAssumeStaples(AppState appState) {
    try {
      return (appState as dynamic).assumeStaples ?? true;
    } catch (e) {
      return true;
    }
  }
}
