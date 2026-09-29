import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'MealCraft';
  static const String tagline = 'Turn what you have into something delicious.';
  
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  
  static const double borderRadius = 16.0;
  static const double borderRadiusSmall = 12.0;
  
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 600);
  
  static const List<String> equipmentList = [
    'Gas Stove',
    'Induction',
    'Oven',
    'Microwave',
    'Air Fryer',
    'Pressure Cooker',
    'Pan',
    'Pot',
    'Tawa',
    'Blender',
    'Mixer Grinder',
  ];
  
  static const Map<String, IconData> equipmentIcons = {
    'Gas Stove': Icons.local_fire_department,
    'Induction': Icons.electric_bolt,
    'Oven': Icons.microwave,
    'Microwave': Icons.microwave,
    'Air Fryer': Icons.air,
    'Pressure Cooker': Icons.soup_kitchen,
    'Pan': Icons.flatware,
    'Pot': Icons.soup_kitchen,
    'Tawa': Icons.circle,
    'Blender': Icons.blender,
    'Mixer Grinder': Icons.blender,
  };
  
  static const List<String> defaultEquipment = [
    'Gas Stove',
    'Pan',
    'Pot',
  ];
}
