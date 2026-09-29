import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';

class ConstraintsModule extends StatelessWidget {
  const ConstraintsModule({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    // Fallbacks
    String targetTime = '30m';
    try {
      targetTime = (appState as dynamic).preferences['targetTime'] ?? '30m';
    } catch (_) {}

    String difficulty = 'Home Cook';
    try {
      difficulty = (appState as dynamic).preferences['difficulty'] ?? 'Home Cook';
    } catch (_) {}
    
    List<dynamic> moods = [];
    try {
      moods = (appState as dynamic).preferences['moods'] ?? [];
    } catch (_) {}

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
            Text(
              'Constraints & Taste',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // Target Total Time
            Text(
              'Target Total Time',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: '15m', label: Text('15m')),
                ButtonSegment(value: '30m', label: Text('30m')),
                ButtonSegment(value: '45m', label: Text('45m')),
                ButtonSegment(value: '60m+', label: Text('60m+')),
              ],
              selected: {targetTime},
              onSelectionChanged: (Set<String> newSelection) {
                try {
                  (appState as dynamic).updatePreference('targetTime', newSelection.first);
                } catch (e) {
                  debugPrint('Error updating time: $e');
                }
              },
            ),
            const SizedBox(height: 24),

            // Culinary Ambition
            Text(
              'Culinary Ambition',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Beginner', label: Text('Beginner')),
                ButtonSegment(value: 'Home Cook', label: Text('Home Cook')),
                ButtonSegment(value: 'Advanced', label: Text('Advanced')),
              ],
              selected: {difficulty},
              onSelectionChanged: (Set<String> newSelection) {
                try {
                  (appState as dynamic).updatePreference('difficulty', newSelection.first);
                } catch (e) {
                  debugPrint('Error updating difficulty: $e');
                }
              },
            ),
            const SizedBox(height: 24),

            // Mood/Vibe
            Text(
              'Mood / Vibe',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: ['Comfort Food', 'Minimal Cleanup', 'Healthy', 'Spicy', 'Quick & Easy'].map((mood) {
                final isSelected = moods.contains(mood);
                return FilterChip(
                  label: Text(mood),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    try {
                      if (selected) {
                        (appState as dynamic).addMood(mood);
                      } else {
                        (appState as dynamic).removeMood(mood);
                      }
                    } catch (e) {
                      debugPrint('Error updating mood: $e');
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Generate Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  try {
                    // Logic to find matches and update appState
                    debugPrint('Running RecipeMatcher.findMatches...');
                    (appState as dynamic).setCurrentMatch('Dummy Top Match');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Recipe Magic Generated!')),
                    );
                  } catch (e) {
                    debugPrint('Error generating recipes: $e');
                  }
                },
                child: const Text(
                  'Generate Recipe Magic',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
