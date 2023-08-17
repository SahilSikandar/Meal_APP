import 'package:flutter/material.dart';
import 'package:meal_app/models/meal_model.dart';

import '../Widgets/meal_item.dart';

class FavScreen extends StatelessWidget {
  List<Meal> favoriteMeal;
  FavScreen(this.favoriteMeal);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeal.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "There is no favorite meal included yet- include your favorite meal",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (_, index) {
          return MealItem(
            id: favoriteMeal[index].id,
            affordability: favoriteMeal[index].affordability,
            complexity: favoriteMeal[index].complexity,
            imgUrl: favoriteMeal[index].imageUrl,
            duration: favoriteMeal[index].duration,
            title: favoriteMeal[index].title,
            //removeItem: removeMealItem,
          );
        },
        itemCount: favoriteMeal.length,
      );
    }
  }
}
