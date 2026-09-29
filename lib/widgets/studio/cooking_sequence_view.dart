import 'package:flutter/material.dart';

class CookingSequenceView extends StatelessWidget {
  const CookingSequenceView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabNav(theme),
        const SizedBox(height: 16),
        _buildPhaseCard(
          theme: theme,
          step: '01',
          title: 'Phase 1: Mise en Place & Water Boil',
          apparatus: 'Apparatus: Chef\'s Knife, Cutting Board, Large Stockpot',
          time: '8 Mins Prep',
          body: 'Fill the Large Stockpot with 4 quarts of water, add 2 tbsp kosher salt, and bring to a rolling boil over high flame.\n\nFinely mince the 5 cloves garlic. Halve the 1 pint cherry tomatoes. Pat dry the 450g chicken thighs with paper towel; season both sides aggressively with salt and freshly cracked black pepper.',
          isActive: false,
        ),
        const SizedBox(height: 16),
        _buildPhaseCard(
          theme: theme,
          step: '02',
          title: 'Phase 2: Cast Iron Sear & Fond Building',
          apparatus: 'Apparatus: Cast Iron Skillet • Heat Target: 375°F - 400°F',
          time: '06:00 Timer',
          body: 'Place the dry cast iron skillet over medium-high heat until wisps of smoke rise. Swirl in 1.5 tbsp olive oil.\n\nLay the seasoned chicken thighs smooth-side down. Do not move them for 5 to 6 minutes to build a deep, mahogany fond crust. Flip and cook for another 4 minutes until internal thermometer reads 165°F. Transfer chicken to a cutting board to rest.',
          isActive: true,
          showChefNote: true,
        ),
        const SizedBox(height: 16),
        _buildPhaseCard(
          theme: theme,
          step: '03',
          title: 'Phase 3: Tomato Blister, Cream Emulsion & Tagliatelle Fold',
          apparatus: 'Apparatus: Cast Iron Skillet + Stockpot Pasta Basket',
          time: '04:30 Timer',
          body: 'Drop 250g dry tagliatelle into boiling salted water; cook 1 minute less than package directions (approx 7 mins total).\n\nIn the still-hot cast iron skillet over medium heat, toss in the halved tomatoes and minced garlic. Sauté for 90 seconds until garlic is fragrant and tomatoes begin to release their juices. Deglaze with a splash of pasta water. Pour in 1/2 cup heavy cream and stir in the grated Parmesan.\n\nFold in 200g baby spinach until just wilted (30 seconds). Using tongs, lift pasta straight from the stockpot into the sauce. Toss vigorously to emulsify. Slice rested chicken and fan over pasta.',
          isActive: false,
          showCompleteButton: true,
        ),
      ],
    );
  }

  Widget _buildTabNav(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'Step-by-Step Equipment & Prep Flow',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Text(
                'Pan Allocation Matrix',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Text(
                'Substitutions & Variations',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseCard({
    required ThemeData theme,
    required String step,
    required String title,
    required String apparatus,
    required String time,
    required String body,
    required bool isActive,
    bool showChefNote = false,
    bool showCompleteButton = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: isActive ? Border.all(color: theme.colorScheme.primaryContainer, width: 2) : null,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive ? theme.colorScheme.primaryContainer : theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      step,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        apparatus,
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  time,
                  style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            body,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              height: 1.5,
            ),
          ),
          if (showChefNote) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHigh.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.tips_and_updates, color: theme.colorScheme.secondary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chef\'s Science Note', style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          'The brown caramelized bits stuck to the bottom of the skillet (the fond) hold the concentrated glutamates that turn your garlic cream sauce from flat to restaurant quality. Avoid non-stick pans here!',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (showCompleteButton) ...[
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Complete Recipe'),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
