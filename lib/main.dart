import 'package:flutter/material.dart';
import 'package:meal_app/Screens/Filters_screen.dart';
import 'package:meal_app/Screens/bottom_bar_screen.dart';
import 'package:meal_app/Screens/category_meal_screen.dart';
import 'package:meal_app/Screens/catogries_screen.dart';
import 'package:meal_app/Screens/meal_detail_Screen.dart';

import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal_model.dart';
import 'package:meal_app/utlis/routes.dart';
import 'package:meal_app/utlis/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegtarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  void filtersMeals(Map<String, bool> _filtersData) {
    setState(() {
      _filters = _filtersData;
      availableMeals = DUMMY_MEALS.where((element) {
        if (_filters['gluten']! && !element.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !element.isVegan) {
          return false;
        }
        if (_filters['vegtarian']! && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavrite(String id) {
    final existingMeal =
        _favoriteMeals.indexWhere((element) => element.id == id);
    if (existingMeal >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingMeal);
      });
    } else {
      setState(() {
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == id));
      });
    }
  }

  void _isFavorite(String mealId) {
    _favoriteMeals.any((element) => element.id == mealId);
  }

  final List<Meal> _favoriteMeals = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeClass().theme,
      //initialRoute: Routes.routebottomNavigationBar,
      routes: {
        '/': (_) => TabsScreen(favoriteMeal: _favoriteMeals),
        Routes.routeCategoryList: (_) => const CatogriesList(),
        Routes.routeCategoryMealScreen: (_) =>
            CategoryMealScreen(availableMeals),
        Routes.routeCategoryMealDetailScreen: (_) =>
            MealDetailScreen(_toggleFavrite, _isFavorite),
        Routes.routeFiltersScreen: (_) =>
            FiltersScreen(currentFilters: _filters, filtersMeal: filtersMeals),
      },
    );
  }
}
