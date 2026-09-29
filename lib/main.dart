import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealcraft/services/app_state.dart';
import 'package:mealcraft/theme/app_theme.dart';
import 'package:mealcraft/screens/studio_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = AppState();
  await appState.init();
  runApp(
    ChangeNotifierProvider.value(
      value: appState,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealCraft Studio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const StudioScreen(),
    );
  }
}
