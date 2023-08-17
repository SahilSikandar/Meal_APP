import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:meal_app/Widgets/drawer.dart';

class FiltersScreen extends StatefulWidget {
  final Function filtersMeal;
  final Map<String, bool> currentFilters;
  FiltersScreen(
      {required this.filtersMeal, required this.currentFilters, super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _gluactoneFree = false;
  var _vegan = false;
  var _vegtarian = false;
  var _lactoseFree = false;
  Widget _switchTile(String name, bool value,
      void Function(bool? a)? _onchanged, String description) {
    return SwitchListTile(
      value: value,
      onChanged: _onchanged,
      title: Text(name, style: TextStyle(color: Colors.white, fontSize: 17)),
      subtitle: Text(description,
          style: TextStyle(
            color: Colors.white,
          )),
    );
  }

  @override
  void initState() {
    _gluactoneFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegtarian = widget.currentFilters['vegtarian']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _advancedDrawerController = AdvancedDrawerController();
    return AdvancedDrawer(
        drawer: DrawerWidget(),
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor,
              ],
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
          appBar: AppBar(
            title: Text('Filters'),
            actions: [
              IconButton(
                  onPressed: () {
                    final selectedMeals = {
                      'gluten': _gluactoneFree,
                      'lactose': _lactoseFree,
                      'vegan': _vegan,
                      'vegtarian': _vegtarian,
                    };
                    widget.filtersMeal(selectedMeals);
                  },
                  icon: Icon(Icons.save))
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "Filters Out Meals!",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  _switchTile("Gluten Free", _gluactoneFree, (value) {
                    setState(() {
                      _gluactoneFree = value!;
                    });
                  }, "Include Gluten Free"),
                  _switchTile("Vegan", _vegan, (value) {
                    setState(() {
                      _vegan = value!;
                    });
                  }, "Include Vegan Meal"),
                  _switchTile("vegtarian", _vegtarian, (value) {
                    setState(() {
                      _vegtarian = value!;
                    });
                  }, "Include vegtarian Meal"),
                  _switchTile("Lactose Free", _lactoseFree, (value) {
                    setState(() {
                      _lactoseFree = value!;
                    });
                  }, "Include Lactose Free")
                ],
              )),
            ],
          ),
        ));
  }
}
