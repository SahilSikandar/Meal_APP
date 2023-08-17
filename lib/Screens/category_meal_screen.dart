import 'package:flutter/material.dart';
import 'package:meal_app/Widgets/meal_item.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal_model.dart';

class CategoryMealScreen extends StatefulWidget {
  List<Meal> availableMeals;
  CategoryMealScreen(this.availableMeals);

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  late String titleData;
  late List<Meal> displayedMeals;
  var _isDataLoaded = false;
  void removeMealItem(String mealId) {
    setState(() {
      displayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_isDataLoaded) {
      final routeArgu =
          ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
      final idData = routeArgu['id'];
      titleData = routeArgu['title'].toString();
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(idData);
      }).toList();
      _isDataLoaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(titleData.toString()),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return MealItem(
            id: displayedMeals[index].id,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            imgUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            title: displayedMeals[index].title,
            // removeItem: removeMealItem,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
