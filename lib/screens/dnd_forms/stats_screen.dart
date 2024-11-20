import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_creator/data/race_data.dart';
import 'package:dnd_character_creator/screens/dnd_forms/equipment_selection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Buttons/navigation_button.dart';
import '../../widgets/buttons/expandable_fab.dart';
import '../../widgets/dice_roller.dart';
import '../../widgets/dnd_form_widgets/main_drawer.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({
    super.key,
    required this.characterName,
    required this.selectedRace,
  });

  final String characterName;
  final String selectedRace;

  @override
  State<StatefulWidget> createState() {
    return _StatsScreenState();
  }
}

class _StatsScreenState extends State<StatsScreen> {
  String _selectedRace = 'Tiefling'; // Default race
  final Map<String, int> abilityScores = {}; // Ability scores to be updated
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

  Future<void> _saveSelections() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not authenticated');
      return;
    }
    final userId = user.uid;

    try {
      final firestore = FirebaseFirestore.instance;
      final docRef = firestore
          .collection('app_user_profiles')
          .doc(userId)
          .collection('characters')
          .doc(widget.characterName);

      // Save the scores with race bonuses applied
      final raceData = RaceData[widget.selectedRace];
      final Map<String, int> bonuses = raceData?['abilityScoreIncrease'] ?? {};
      final Map<String, int> scoresToSave = abilityScores.map((key, value) {
        final bonus = bonuses[key] ?? 0;
        return MapEntry(key, value + bonus);
      });

      await docRef.set(
        {'abilityScores': scoresToSave},
        SetOptions(merge: true),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data saved successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save data: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = PointBuy(
      customColor: customColor,
      showSnackbar: showSnackbar,
      selectedRace: widget.selectedRace,
      onScoresChanged: (newScores) {
        setState(() {
          abilityScores.clear();
          abilityScores.addAll(newScores);
        });
      },
    );

    if (index == 1) {
      mainContent = Center(
        child: DiceRoller(customColor: customColor),
      );
    } else if (index == 2) {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EquipmentSelection(),
                ),
              );
            },
            textContent: 'Next',
          ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        distance: 112,
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
        ],
      ),
      body: mainContent,
    );
  }
}

class PointBuy extends StatefulWidget {
  const PointBuy({
    super.key,
    required this.customColor,
    required this.showSnackbar,
    required this.selectedRace,
    required this.onScoresChanged,
  });

  final Color customColor;
  final String selectedRace;
  final Function(String) showSnackbar;
  final Function(Map<String, int>) onScoresChanged;

  @override
  State<PointBuy> createState() => _PointBuyState();
}

class _PointBuyState extends State<PointBuy> {
  final Map<String, int> baseScores = {
    'Strength': 8,
    'Dexterity': 8,
    'Constitution': 8,
    'Wisdom': 8,
    'Intelligence': 8,
    'Charisma': 8,
  };

  int pointsLeft = 27;

  Map<String, int> get displayedScores {
    final raceData = RaceData[widget.selectedRace];
    final Map<String, int> bonuses = raceData?['abilityScoreIncrease'] ?? {};

    return baseScores.map((key, value) {
      final bonus = bonuses[key] ?? 0;
      return MapEntry(key, value + bonus);
    });
  }

  void incrementSkill(String skill) {
    final score = baseScores[skill]! + 1;
    final cost = (score <= 13) ? 1 : 2;

    setState(() {
      if (pointsLeft >= cost && baseScores[skill]! < 15) {
        baseScores[skill] = score;
        pointsLeft -= cost;
        widget.onScoresChanged(baseScores);
      } else {
        widget.showSnackbar(
            'You do not have enough points left to increase $skill!');
      }
    });
  }

  void decrementSkill(String skill) {
    final score = baseScores[skill]! - 1;
    final cost = (baseScores[skill]! <= 14) ? 1 : 2;

    setState(() {
      if (score >= 8) {
        baseScores[skill] = score;
        pointsLeft += cost;
        widget.onScoresChanged(baseScores);
      }
    });
  }

  Widget buildSkillRow(String label, int skillValue, Function increment,
      Function decrement) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.black, fontSize: 18)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => decrement(),
              icon: Icon(Icons.arrow_downward_sharp, color: widget.customColor),
            ),
            Container(
              decoration: BoxDecoration(
                color: widget.customColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              height: 100,
              width: 100,
              child: Center(
                child: Text(
                  "$skillValue",
                  style: const TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
            ),
            IconButton(
              onPressed: () => increment(),
              icon: Icon(Icons.arrow_upward_sharp, color: widget.customColor),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    // Apply race bonuses after the widget has been built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.onScoresChanged(baseScores);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildSkillRow(
                "Strength",
                displayedScores['Strength']!,
                () => incrementSkill("Strength"),
                () => decrementSkill("Strength"),
              ),
              buildSkillRow(
                "Dexterity",
                displayedScores['Dexterity']!,
                () => incrementSkill("Dexterity"),
                () => decrementSkill("Dexterity"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildSkillRow(
                "Constitution",
                displayedScores['Constitution']!,
                () => incrementSkill("Constitution"),
                () => decrementSkill("Constitution"),
              ),
              buildSkillRow(
                "Wisdom",
                displayedScores['Wisdom']!,
                () => incrementSkill("Wisdom"),
                () => decrementSkill("Wisdom"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildSkillRow(
                "Intelligence",
                displayedScores['Intelligence']!,
                () => incrementSkill("Intelligence"),
                () => decrementSkill("Intelligence"),
              ),
              buildSkillRow(
                "Charisma",
                displayedScores['Charisma']!,
                () => incrementSkill("Charisma"),
                () => decrementSkill("Charisma"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Points Left: $pointsLeft",
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
