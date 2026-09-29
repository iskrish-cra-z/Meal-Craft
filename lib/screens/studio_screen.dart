import 'package:flutter/material.dart';
import 'package:mealcraft/widgets/studio/header_ribbon.dart';
import 'package:mealcraft/widgets/studio/pantry_module.dart';
import 'package:mealcraft/widgets/studio/equipment_module.dart';
import 'package:mealcraft/widgets/studio/constraints_module.dart';
import 'package:mealcraft/widgets/studio/recipe_hero_card.dart';
import 'package:mealcraft/widgets/studio/macro_strip.dart';
import 'package:mealcraft/widgets/studio/cooking_sequence_view.dart';
import 'package:mealcraft/widgets/studio/allocation_matrix.dart';

class StudioScreen extends StatelessWidget {
  const StudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderRibbon(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >= 900) {
                    // Desktop / Tablet layout
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 380,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const PantryModule(),
                                const SizedBox(height: 24),
                                const EquipmentModule(),
                                const SizedBox(height: 24),
                                const ConstraintsModule(),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const RecipeHeroCard(),
                                const SizedBox(height: 24),
                                const MacroStrip(),
                                const SizedBox(height: 24),
                                const CookingSequenceView(),
                                const SizedBox(height: 24),
                                const AllocationMatrix(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Mobile Layout
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const PantryModule(),
                          const SizedBox(height: 16),
                          const EquipmentModule(),
                          const SizedBox(height: 16),
                          const ConstraintsModule(),
                          const SizedBox(height: 32),
                          const Divider(),
                          const SizedBox(height: 32),
                          const RecipeHeroCard(),
                          const SizedBox(height: 16),
                          const MacroStrip(),
                          const SizedBox(height: 16),
                          const CookingSequenceView(),
                          const SizedBox(height: 16),
                          const AllocationMatrix(),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
