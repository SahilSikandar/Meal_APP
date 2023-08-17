import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meal_app/Screens/category_meal_screen.dart';
import 'package:meal_app/utlis/routes.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  String? id;
  CategoryItem({required this.title, required this.imageUrl, this.id});
  void navigateTo(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(Routes.routeCategoryMealScreen,
        arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateTo(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          height: 100,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
          ),
          child: Stack(
            children: [
              //Blur Effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                // child: Container(),
              ),
              //Gradient Effect
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.20)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.05),
                      ]),
                ),
              ),
              //Child
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 100,
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              imageUrl,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(title, style: Theme.of(context).textTheme.headline1)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
