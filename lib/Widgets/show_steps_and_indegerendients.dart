import 'package:flutter/material.dart';

import '../dummy_data.dart';

class ShowList extends StatefulWidget {
  const ShowList({super.key});

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  bool _isExpanded = false;
  bool _showIngredients = false;
  @override
  Widget build(BuildContext context) {
    final idData = ModalRoute.of(context)!.settings.arguments as String;
    final catogreyMealDetails = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == idData;
    });
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                color: Colors.white,
                icon: Icon(
                    _showIngredients ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _showIngredients = !_showIngredients;
                  });
                },
              ),
            ),
            if (_showIngredients)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: catogreyMealDetails.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(catogreyMealDetails.ingredients[index]),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'Steps',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        color: Colors.white,
                        icon: Icon(_isExpanded
                            ? Icons.expand_less
                            : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                      ),
                    ),
                    if (_isExpanded)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: catogreyMealDetails.steps.length,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text('# ${(index + 1)}'),
                            ),
                            title: Text(
                              catogreyMealDetails.steps[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      )
                    else
                      Column(
                        children: catogreyMealDetails.steps
                            .take(
                                2) // Show only 2 catogreyMealDetails.steps when not expanded
                            .map((step) => ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                        '${catogreyMealDetails.steps.indexOf(step) + 1}'),
                                  ),
                                  title: Text(step,
                                      style: TextStyle(color: Colors.white)),
                                ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
