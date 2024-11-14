import 'package:flutter/material.dart';
import 'package:dnd_character_creator/Widgets/main_drawer.dart';

import '../Widgets/navigation_button.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StatsScreenState();
  }
}

class _StatsScreenState extends State<StatsScreen> {
  final pointBuyMax = 27;
  int pointsLeft = 27;
  int strength = 8;
  int dexterity = 8;
  int constitution = 8;
  int wisdom = 8;
  int intelligence = 8;
  int charisma = 8;

  final Color customColor = const Color.fromARGB(255, 138, 28, 20);

  void incrementSkill(String skill) {
    setState(() {
      if (pointsLeft > 0) {
        switch (skill) {
          case "strength":
            if (strength < 15) {
              strength++;
              pointsLeft--;
            }
            break;
          case "dexterity":
            if (dexterity < 15) {
              dexterity++;
              pointsLeft--;
            }
            break;
          case "constitution":
            if (constitution < 15) {
              constitution++;
              pointsLeft--;
            }
            break;
          case "wisdom":
            if (wisdom < 15) {
              wisdom++;
              pointsLeft--;
            }
            break;
          case "intelligence":
            if (intelligence < 15) {
              intelligence++;
              pointsLeft--;
            }
            break;
          case "charisma":
            if (charisma < 15) {
              charisma++;
              pointsLeft--;
            }
            break;
        }
      }
    });
  }

  void decrementSkill(String skill) {
    setState(() {
      switch (skill) {
        case "strength":
          if (strength > 8) {
            strength--;
            pointsLeft++;
          }
          break;
        case "dexterity":
          if (dexterity > 8) {
            dexterity--;
            pointsLeft++;
          }
          break;
        case "constitution":
          if (constitution > 8) {
            constitution--;
            pointsLeft++;
          }
          break;
        case "wisdom":
          if (wisdom > 8) {
            wisdom--;
            pointsLeft++;
          }
          break;
        case "intelligence":
          if (intelligence > 8) {
            intelligence--;
            pointsLeft++;
          }
          break;
        case "charisma":
          if (charisma > 8) {
            charisma--;
            pointsLeft++;
          }
          break;
      }
    });
  }

  Widget buildSkillRow(
      String label, int skillValue, Function increment, Function decrement) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.black, fontSize: 18)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                decrement();
              },
              icon: Icon(Icons.arrow_downward_sharp, color: customColor),
            ),
            Container(
              decoration: BoxDecoration(
                color: customColor, // Set the background color
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              height: 100,
              width: 100,
              child: Center(
                child: Text(
                  "$skillValue",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50), // Set text color to white
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                increment();
              },
              icon: Icon(Icons.arrow_upward_sharp, color: customColor),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
          NavigationButton(onPressed: () {}, textContent: 'Next'),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                buildSkillRow(
                  "Strength",
                  strength,
                  () => incrementSkill("strength"),
                  () => decrementSkill("strength"),
                ),
                const SizedBox(width: 8),
                buildSkillRow(
                  "Dexterity",
                  dexterity,
                  () => incrementSkill("dexterity"),
                  () => decrementSkill("dexterity"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                buildSkillRow(
                    "Constitution",
                    constitution,
                    () => incrementSkill("constitution"),
                    () => decrementSkill("constitution")),
                const SizedBox(width: 8),
                buildSkillRow(
                  "Wisdom",
                  wisdom,
                  () => incrementSkill("wisdom"),
                  () => decrementSkill("wisdom"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                buildSkillRow(
                  "Intelligence",
                  intelligence,
                  () => incrementSkill("intelligence"),
                  () => decrementSkill("intelligence"),
                ),
                const SizedBox(width: 8),
                buildSkillRow(
                  "Charisma",
                  charisma,
                  () => incrementSkill("charisma"),
                  () => decrementSkill("charisma"),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: customColor,
                  width: 3,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              height: 50,
              width: 300,
              child: Center(
                child: Text(
                  "Points Left: $pointsLeft",
                  style: TextStyle(color: customColor, fontSize: 30),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
