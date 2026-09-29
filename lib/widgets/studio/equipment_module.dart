import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../constants/app_constants.dart';

class EquipmentModule extends StatelessWidget {
  const EquipmentModule({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    
    // Fallback if not available
    List<dynamic> equipmentList = [];
    try {
      equipmentList = (AppConstants as dynamic).equipmentList ?? [];
    } catch (_) {
      equipmentList = ['Oven', 'Stovetop', 'Microwave', 'Blender', 'Air Fryer', 'Food Processor'];
    }

    List<dynamic> selectedEquipment = [];
    try {
      selectedEquipment = (appState as dynamic).selectedEquipment ?? [];
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
            Row(
              children: [
                Text(
                  'Available Equipment',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Badge(
                  label: Text('${selectedEquipment.length}'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: equipmentList.map((equipment) {
                final isSelected = selectedEquipment.contains(equipment);
                
                return ActionChip(
                  label: Text(equipment.toString()),
                  backgroundColor: isSelected 
                      ? Theme.of(context).colorScheme.primaryContainer 
                      : Theme.of(context).colorScheme.surfaceContainer,
                  labelStyle: TextStyle(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.onPrimary 
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  side: isSelected ? BorderSide.none : BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () {
                    try {
                      (appState as dynamic).toggleEquipment(equipment);
                    } catch (e) {
                      debugPrint('Error toggling equipment: $e');
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
