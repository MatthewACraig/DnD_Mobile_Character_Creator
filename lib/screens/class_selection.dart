import 'package:dnd_character_creator/screens/background_selection.dart';
import 'package:dnd_character_creator/screens/specifics_selection.dart';
import 'package:dnd_character_creator/widgets/loaders/class_data_loader.dart';
import 'package:dnd_character_creator/widgets/buttons/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:dnd_character_creator/widgets/buttons/button_with_padding.dart';


class ClassSelection extends StatefulWidget {
  const ClassSelection({Key? key}) : super(key: key);

  @override
  _ClassSelectionState createState() => _ClassSelectionState();
}

class _ClassSelectionState extends State<ClassSelection> {
  String selectedClassName = 'Sorcerer'; // Default class

  void updateSelectedClass(String className) {
    setState(() {
      selectedClassName = className;
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
                
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BackgroundScreen(characterID: 1)));
              },
              textContent: 'Next'),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Class Selection',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
            width: 15,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Center(
                child: Text(
                  'Pick your class',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            children: <Widget>[
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Barbarian'),
                textContent: 'Barbarian',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Bard'),
                textContent: 'Bard',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Cleric'),
                textContent: 'Cleric',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Druid'),
                textContent: 'Druid',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Fighter'),
                textContent: 'Fighter',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Monk'),
                textContent: 'Monk',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Paladin'),
                textContent: 'Paladin',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Ranger'),
                textContent: 'Ranger',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Rogue'),
                textContent: 'Rogue',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Sorcerer'),
                textContent: 'Sorcerer',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Warlock'),
                textContent: 'Warlock',
              ),
              ButtonWithPadding(
                onPressed: () => updateSelectedClass('Wizard'),
                textContent: 'Wizard',
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
                child: ClassDataWidget(className: selectedClassName),
              ),
            ),
          ),

          // Row(
          //   children: [
          //     SizedBox(width: 6),
          //     NavigationButton(
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //         textContent: 'Back'),
          //     SizedBox(width: 30),
          //     NavigationButton(onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(builder:(context) => StatsScreen(),));
          //     }, textContent: 'Next'),
          //   ],
          // ),
        ],
      ),
    );
  }
}
