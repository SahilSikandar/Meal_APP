import 'package:flutter/material.dart';
import 'package:meal_app/Widgets/category_item.dart';
import 'package:meal_app/dummy_data.dart';

class CatogriesList extends StatelessWidget {
  const CatogriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2.3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: Dummy_CATEGORIES.map((e) => CategoryItem(
                title: e.title,
                id: e.id,
                imageUrl: e.img.toString(),
              )).toList()),
    );
  }
}
