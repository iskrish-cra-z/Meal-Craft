import 'package:flutter/material.dart';

class AllocationMatrix extends StatelessWidget {
  const AllocationMatrix({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
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
                  Icon(Icons.calendar_view_week, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Equipment & Pan Allocation Timeline',
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
              Text(
                'Prevents burner crowding',
                style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Visualizing how both cooking vessels run in parallel so pasta and pan sauce hit peak temperature simultaneously.',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          _buildTimelineHeader(theme),
          const SizedBox(height: 8),
          _buildTimelineRow(
            theme: theme,
            title: 'Cast Iron Skillet',
            segments: [
              _Segment(flex: 30, text: 'Preheating', color: Colors.transparent, textColor: theme.colorScheme.outline),
              _Segment(flex: 45, text: 'High Sear', color: theme.colorScheme.secondary, textColor: theme.colorScheme.onSecondary),
              _Segment(flex: 25, text: 'Emulsion Sauce', color: theme.colorScheme.primaryContainer, textColor: theme.colorScheme.onPrimary),
            ],
          ),
          const SizedBox(height: 12),
          _buildTimelineRow(
            theme: theme,
            title: 'Large Stockpot',
            segments: [
              _Segment(flex: 60, text: 'Bring to Boil', color: theme.colorScheme.surfaceVariant, textColor: theme.colorScheme.onSurfaceVariant),
              _Segment(flex: 30, text: 'Cook Tagliatelle (7m)', color: theme.colorScheme.primary, textColor: theme.colorScheme.onPrimary),
              _Segment(flex: 10, text: 'Drain', color: Colors.transparent, textColor: theme.colorScheme.outline),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineHeader(ThemeData theme) {
    return Row(
      children: [
        const SizedBox(width: 140),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('00:00 (Prep)', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline)),
              Text('10:00 (Sear)', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline)),
              Text('20:00 (Boil Pasta)', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline)),
              Text('28:00 (Plate)', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineRow({
    required ThemeData theme,
    required String title,
    required List<_Segment> segments,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Container(
            height: 32,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: segments.map((s) => Expanded(
                flex: s.flex,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: s.color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    s.text,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: s.textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _Segment {
  final int flex;
  final String text;
  final Color color;
  final Color textColor;
  _Segment({required this.flex, required this.text, required this.color, required this.textColor});
}
