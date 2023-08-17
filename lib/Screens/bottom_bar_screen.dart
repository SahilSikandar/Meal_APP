// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:meal_app/Screens/catogries_screen.dart';
import 'package:meal_app/Screens/favourite_screen.dart';
import 'package:meal_app/Widgets/drawer.dart';

import '../Widgets/appbar.dart';
import '../Widgets/tabs_icon.dart';
import 'package:meal_app/models/meal_model.dart';

class TabsScreen extends StatefulWidget {
  List<Meal> favoriteMeal;
  TabsScreen({
    Key? key,
    required this.favoriteMeal,
  }) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>>? _pages;
  late int currentPage;
  late TabController tabController;

  final List<Color> colors = [
    Colors.yellow,
    Colors.red,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 2, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    _pages = [
      {
        'page': const CatogriesList(),
        'title': 'Categories',
      },
      {
        'page': FavScreen(widget.favoriteMeal),
        'title': 'Your Favorite',
      },
    ];
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        drawer: DrawerWidget(),
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Theme.of(context).primaryColor, Colors.black54],
            ),
          ),
        ),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOutSine,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        //openScale: 1.0,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black, blurRadius: 4, blurStyle: BlurStyle.outer),
          ],
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: CustomAppBar(
              controller: _advancedDrawerController,
              title: _pages![currentPage]['title'],
            ),
            body: FrostedBottomBar(
              opacity: 0.7,
              sigmaX: 5,
              sigmaY: 5,
              borderRadius: BorderRadius.circular(500),
              duration: const Duration(milliseconds: 800),
              hideOnScroll: true,
              body: (context, controller) => TabBarView(
                  controller: tabController,
                  dragStartBehavior: DragStartBehavior.down,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const CatogriesList(),
                    FavScreen(widget.favoriteMeal)
                  ]),
              child: TabBar(
                indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                controller: tabController,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      color: currentPage == 0 ? colors[0] : Colors.red,
                      width: 4,
                      style: BorderStyle.solid),
                  insets: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                ),
                tabs: [
                  TabsIcon(
                      icons: Icons.home,
                      color: currentPage == 0 ? colors[0] : Colors.white),
                  TabsIcon(
                      icons: Icons.star,
                      color: currentPage == 1 ? colors[1] : Colors.white),
                ],
              ),
            )));
  }
}
