# MealCraft — AI Culinary Studio 🍳

**Turn what you have into something delicious.**

MealCraft is a smart, frontend-only Flutter mobile application designed to act as your personal culinary assistant. Instead of making you shop for specific recipes, MealCraft reverses the process: you input the ingredients currently sitting in your crisper or pantry, the cooking equipment you have available, and your personal constraints (time, difficulty, diet). The app then instantly processes these parameters against a robust local recipe database to generate the perfect "Mise en place" recipe plan for you.

## 🌟 Key Features

*   **Pantry Intelligence**: Simply list what you have on hand. The app matches your ingredients to create minimal-waste, zero-grocery-run meals.
*   **Equipment Allocation**: Select your available tools (e.g., Cast Iron Skillet, Stockpot, Oven) and the app will tailor its heat management and vessel transitions strictly to your kitchen's capabilities.
*   **Smart Constraints**: Filter recipes by target cooking time, your culinary ambition (Beginner to Advanced), and your "Vibe" (e.g., Comfort Food, Minimal Cleanup).
*   **Mise Dashboard**: A stunning, high-density professional dashboard layout that centralizes all your inputs on the left and generates your meal canvas on the right.
*   **Step-by-Step Flow**: Provides inline timers, "Chef's Science Notes", and phase-based cooking instructions so your pasta and pan sauce hit peak temperature simultaneously.
*   **Offline First**: Built entirely without a backend. All recipes, matching algorithms, and user states are processed instantly on your device via Dart and local state management.

## 🏗️ Architecture & Stack

*   **Framework**: Flutter (Dart)
*   **State Management**: `Provider` (Clean separation of AppState, matching logic, and UI).
*   **Design Language**: Material 3 combined with a premium, editorial aesthetic (using Google Fonts `Newsreader` and `Plus Jakarta Sans`).
*   **Data Persistence**: `shared_preferences` for saving user preferences and favorites locally.

## 🚀 Getting Started

Since MealCraft is a frontend Flutter application, you will need the Flutter SDK installed on your machine.

1. **Install Flutter**: Follow the instructions at [flutter.dev](https://docs.flutter.dev/get-started/install).
2. **Clone the repository**:
   ```bash
   git clone https://github.com/iskrish-cra-z/Meal-Craft.git
   cd Meal-Craft
   ```
3. **Fetch dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```
   *(Note: The app is fully responsive and will adapt beautifully to mobile, tablet, or desktop web windows).*

## 📂 Project Structure

The codebase is organized modularly for high readability:
*   `/lib/models/`: Core data structures (`Recipe`, `Ingredient`, `UserPreferences`).
*   `/lib/data/`: The local offline database (`RecipeData`, `IngredientData`).
*   `/lib/services/`: Core logic and state (`AppState`, `RecipeMatcher`, `FavoritesService`).
*   `/lib/screens/`: High-level views (e.g., `StudioScreen` the main dashboard).
*   `/lib/widgets/studio/`: Modular components making up the complex dashboard (Pantry, Equipment, Canvas, MacroStrip, etc.).
*   `/lib/theme/`: Custom editorial color palettes and typography definitions.

---
*Made with ❤️ for home cooks.*