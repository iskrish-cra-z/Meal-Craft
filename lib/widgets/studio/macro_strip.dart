import 'package:flutter/material.dart';

class MacroStrip extends StatelessWidget {
  const MacroStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildPill(theme, theme.colorScheme.primary, '7 Used from Crisper'),
              const SizedBox(width: 12),
              _buildPill(theme, theme.colorScheme.outline, '3 Kitchen Staples'),
              const SizedBox(width: 12),
              _buildPill(theme, theme.colorScheme.secondary, '0 Missing Ingredients'),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildMacro(theme, '620', 'Calories', theme.colorScheme.onSurface),
                _buildDivider(theme),
                _buildMacro(theme, '48g', 'Protein', theme.colorScheme.primary),
                _buildDivider(theme),
                _buildMacro(theme, '34g', 'Carbs', theme.colorScheme.onSurfaceVariant),
                _buildDivider(theme),
                _buildMacro(theme, '28g', 'Fat', theme.colorScheme.secondary),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPill(ThemeData theme, Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildMacro(ThemeData theme, String value, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.outline,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Container(
      height: 24,
      width: 1,
      color: theme.colorScheme.surfaceVariant,
    );
  }
}
