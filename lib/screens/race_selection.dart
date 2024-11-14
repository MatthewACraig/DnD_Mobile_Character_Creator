
import 'package:dnd_character_creator/Widgets/navigation_button.dart';
import 'package:dnd_character_creator/Widgets/race_data_loader.dart';
import 'package:flutter/material.dart';
import 'package:dnd_character_creator/Widgets/button_with_padding.dart';
import 'package:dnd_character_creator/Screens/class_selection.dart';

class RaceSelection extends StatefulWidget {
  const RaceSelection({super.key});

  @override
  _RaceSelectionState createState() => _RaceSelectionState();
}

class _RaceSelectionState extends State<RaceSelection> {
  String selectedRaceName = 'Elf'; // Default class

  void updateSelectedRace(String raceName) {
    setState(() {
      selectedRaceName = raceName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => ClassSelection()));
              },
              textContent: 'Next'),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Race Selection',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Pick your race',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            children: <Widget>[
              ButtonWithPadding(
                onPressed: () => updateSelectedRace('Aasimar'),
                textContent: 'Aasimar',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedRace('Dragonborn'),
                textContent: 'Dragonborn',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedRace('Dwarf'),
                textContent: 'Dwarf',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedRace('Elf'),
                textContent: 'Elf',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedRace('Gnome'),
                textContent: 'Gnome',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedRace('Halfling'),
                textContent: 'Halfling',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedRace('Human'),
                textContent: 'Human',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedRace('Orc'),
                textContent: 'Orc',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedRace('Tiefling'),
                textContent: 'Tiefling',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 350,
              width: 350,
              child: SingleChildScrollView(
                child: RaceDataLoader(raceName: selectedRaceName),
              ),
            ),
          ),
          SizedBox(height: 25),
          // Row(
          //   children: [
          //     SizedBox(width: 176),
              
          //     SizedBox(width: 30),
          //     NavigationButton(onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => ClassSelection()));
          //     }, textContent: 'Next'),
          //   ],
          // ),
        ],
      ),
    );
  }
}
