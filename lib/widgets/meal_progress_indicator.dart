import 'package:flutter/material.dart';

class MealProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String>? stepLabels;

  const MealProgressIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    this.stepLabels,
  }) : assert(currentStep >= 0 && currentStep <= totalSteps),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index % 2 != 0) {
          // Line
          int stepIndex = index ~/ 2;
          bool isCompleted = stepIndex < currentStep;
          return Expanded(
            child: Container(
              height: 2,
              color: isCompleted 
                  ? Theme.of(context).colorScheme.primary 
                  : Theme.of(context).colorScheme.outlineVariant,
            ),
          );
        } else {
          // Dot
          int stepIndex = index ~/ 2;
          bool isActive = stepIndex == currentStep;
          bool isCompleted = stepIndex < currentStep;
          
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive || isCompleted 
                      ? Theme.of(context).colorScheme.primary 
                      : Theme.of(context).colorScheme.surfaceVariant,
                  border: Border.all(
                    color: isActive || isCompleted 
                        ? Theme.of(context).colorScheme.primary 
                        : Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: isCompleted
                      ? Icon(Icons.check, size: 14, color: Theme.of(context).colorScheme.onPrimary)
                      : Text(
                          '${stepIndex + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isActive 
                                ? Theme.of(context).colorScheme.onPrimary 
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                ),
              ),
              if (stepLabels != null && stepIndex < stepLabels!.length)
                Padding(
                  padding: const EdgeInsets.top(4.0),
                  child: Text(
                    stepLabels![stepIndex],
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isActive ? Theme.of(context).colorScheme.primary : null,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
            ],
          );
        }
      }),
    );
  }
}
