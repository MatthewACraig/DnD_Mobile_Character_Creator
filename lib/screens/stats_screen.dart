import 'package:flutter/material.dart';


import '../Widgets/main_drawer.dart';
import '../Widgets/Buttons/navigation_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/buttons/expandable_fab.dart';
import '../widgets/dice_roller.dart';
import '../widgets/point_buy.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key, this.characterID});
  final characterID;

  @override
  State<StatefulWidget> createState() {
    return _StatsScreenState();
  }
}

class _StatsScreenState extends State<StatsScreen> {
  String _selectedRace = 'Tiefling';
  final Map<String, int> abilityScores = {};
  int index = 0;

  final Color customColor = const Color.fromARGB(255, 138, 28, 20);

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(message),
      ),
    );
  }

  void _saveSelections() async {
    final url = Uri.https(
        'dndmobilecharactercreator-default-rtdb.firebaseio.com',
        '${widget.characterID}/stats.json');
    final response = await http.get(url);
    if (response.body != 'null') {
      await http.delete(url);
    }
    await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(abilityScores));
  }


  @override
  Widget build(BuildContext context) {
    Widget mainContent = PointBuy(customColor: customColor, showSnackbar: showSnackbar, selectedRace: _selectedRace,);
    if(index == 1)
    {
      mainContent = Center(
        child: DiceRoller(customColor: customColor,),
      );
    }
    else if(index == 2) {
      mainContent = const Center(
        child: Text('Standard Array'),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Stats"),
        ),
        drawer: const MainDrawer(),
        bottomNavigationBar: Row(
          children: [
            NavigationButton(
              textContent: "Back",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 30),
            NavigationButton(
              onPressed: () {
                _saveSelections();
                // if(pointsLeft != 0)
                //   {
                //     showSnackbar('You have $pointsLeft points left to distribute!');
                //   }
              },
              textContent: 'Next',
            ),
          ],
        ),
        floatingActionButton: ExpandableFab(distance: 112,
          children: [
            ActionButton(
              onPressed: () => setState(() {
                index = 0;
              }),
              icon: const Icon(Icons.edit_note),
            ),
            ActionButton(
              onPressed: () => setState(() {
                index = 1;
              }),
              icon: const Icon(Icons.casino_outlined),
            ),
            ActionButton(
              onPressed: () => setState(() {
                index = 2;
              }),
              icon: const Icon(Icons.checklist),
            ),
          ],),
        body: mainContent
    );
  }
}
