import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_creator/widgets/dnd_form_widgets/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CharacterLoaderScreen extends StatefulWidget {
  const CharacterLoaderScreen({
    super.key,
    required this.characterName,
    required this.characterClass,
    required this.characterBackground,
    required this.characterRace,
    required this.abilityScores,
  });

  final characterName;
  final characterClass;
  final characterBackground;
  final characterRace;
  final abilityScores;

  @override
  State<StatefulWidget> createState() {
    return _CharacterLoaderScreenState();
  }
}

class _CharacterLoaderScreenState extends State<CharacterLoaderScreen> {
  

  bool _isLoading = false;

  // Map<String, int> abilityScores = {
  //   'Strength': 8,
  //   'Dexterity': 16,
  //   'Constitution': 14,
  //   'Intelligence': 10,
  //   'Wisdom': 14,
  //   'Charisma': 12
  // };
  List<String> chosenProficiencies = [
    "Acrobatics",
    "Perception",
    "Stealth",
    "Persuasion",
    "Investigation",
  ];
  final Map<String, int> modifiers = {
    'Strength': 0,
    'Dexterity': 0,
    'Constitution': 0,
    'Intelligence': 0,
    'Wisdom': 0,
    'Charisma': 0
  };

  final Map<String, String> skills = {
    'Acrobatics': 'Dexterity',
    'Animal Handling': 'Wisdom',
    'Arcana': 'Intelligence',
    'Athletics': 'Strength',
    'History': 'Intelligence',
    'Insight': 'Wisdom',
    'Intimidation': 'Charisma',
    'Investigation': 'Intelligence',
    'Medicine': 'Wisdom',
    'Nature': 'Intelligence',
    'Perception': 'Wisdom',
    'Performance': 'Charisma',
    'Persuasion': 'Charisma',
    'Religion': 'Intelligence',
    'Sleight of Hand': 'Dexterity',
    'Stealth': 'Dexterity',
    'Survival': 'Wisdom',
  };

 

  String _currentSection = 'Abilities';
  Color customColor = const Color.fromARGB(255, 138, 28, 20);
  final int proficiencyBonus = 2;

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(message),
      ),
    );
  }

  void setModifiers() {
    setState(() {
      modifiers['Strength'] = ((widget.abilityScores['Strength'] ?? 8) - 10) ~/ 2;
      modifiers['Dexterity'] = ((widget.abilityScores['Dexterity'] ?? 8) - 10) ~/ 2;
      modifiers['Constitution'] = ((widget.abilityScores['Constitution'] ?? 8) - 10) ~/ 2;
      modifiers['Intelligence'] = ((widget.abilityScores['Intelligence'] ?? 8) - 10) ~/ 2;
      modifiers['Wisdom'] = ((widget.abilityScores['Wisdom'] ?? 8)- 10) ~/ 2;
      modifiers['Charisma'] = ((widget.abilityScores['Charisma'] ?? 8)- 10) ~/ 2;
    });
  }

  @override
  void initState() {
    super.initState();
    
    setModifiers();
  }

  void setMainContent(String type) {
    setState(() {
      _currentSection = type;
    });
  }

  Widget showStats(int skillValue, String skillName) {
    return Column(
      children: [
        Text(skillName,
            style: const TextStyle(color: Colors.black, fontSize: 20)),
        Container(
          decoration: BoxDecoration(
            color: customColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          height: 100,
          width: 100,
          child: Center(
            child: Column(
              children: [
                Text(
                  "$skillValue",
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                ),
                if (modifiers[skillName]! >= 0)
                  Text(
                    "+${modifiers[skillName]}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                if (modifiers[skillName]! < 0)
                  Text(
                    "${modifiers[skillName]}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget abilitiesScreen() {
    return Column(
      children: [
        const Text(
          "Abilities",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 25),
            showStats(widget.abilityScores['Strength'] ?? 8, 'Strength'),
            const Spacer(),
            showStats(widget.abilityScores['Dexterity'] ?? 8, 'Dexterity'),
            const Spacer(),
            showStats(widget.abilityScores['Constitution'] ?? 8, 'Constitution'),
            const SizedBox(width: 25),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 25),
            showStats(widget.abilityScores['Intelligence'] ?? 8, 'Intelligence'),
            const Spacer(),
            showStats(widget.abilityScores['Wisdom'] ?? 8, 'Wisdom'),
            const Spacer(),
            showStats(widget.abilityScores['Charisma'] ?? 8, 'Charisma'),
            const SizedBox(width: 25),
          ],
        ),
        const SizedBox(height: 20),
        buildProficiencies(),
      ],
    );
  }

 Widget weaponsScreen() {
    return Column(
      children: [
        Text('Welp, no weapons yet'),
      ],
    );
  }

  Widget buildProficiencies() {
    const TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);
    return Column(
      children: [
        const Text(
          "Proficiencies",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 5,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: skills.keys.length,
          itemBuilder: (context, index) {
            String proficiency = skills.keys.elementAt(index);
            String ability = skills[proficiency] ?? 'Strength'; //editied may need to come back to this
            int abilityModifier = modifiers[ability] ?? 0;
            bool isProficient = chosenProficiencies.contains(proficiency);
            int totalModifier =
                abilityModifier + (isProficient ? proficiencyBonus : 0);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    proficiency,
                    style: isProficient ? textStyle : null,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    " ${totalModifier >= 0 ? '+' : ''}$totalModifier",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Container();
    if (_currentSection == 'Abilities') {
      mainContent = abilitiesScreen();
    } else if (_currentSection == 'Weapons') {
      mainContent = weaponsScreen();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Character")),
      drawer: const MainDrawer(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SegmentedButton<String>(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(WidgetState.selected)) {
                  return customColor;
                }
                return Colors.grey;
              },
            ),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
          showSelectedIcon: false,
          segments: const <ButtonSegment<String>>[
            ButtonSegment<String>(
              value: 'Abilities',
              label:
                  SizedBox(width: 130, child: Center(child: Text('Abilities'))),
              icon: Icon(Icons.catching_pokemon),
            ),
            ButtonSegment<String>(
              value: 'Weapons',
              label:
                  SizedBox(width: 130, child: Center(child: Text('Weapons'))),
              icon: Icon(Icons.language),
            ),
          ],
          selected: {_currentSection},
          emptySelectionAllowed: false,
          onSelectionChanged: (Set<String> newSelection) {
            setState(() {
              _currentSection = newSelection.first;
            });
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 30),
              Container(
                decoration: BoxDecoration(
                  color: customColor,
                ),
                width: 65,
                height: 65,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  widget.characterName,
                  style: TextStyle(
                    color: customColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 30),
            ],
          ),
          const SizedBox(height: 20),
          // Make everything below this scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Race: ${widget.characterRace}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            'Class: ${widget.characterClass}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            'Background: ${widget.characterBackground}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 15),
                  mainContent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}