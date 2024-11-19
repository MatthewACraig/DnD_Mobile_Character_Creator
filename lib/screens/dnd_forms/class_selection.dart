import 'package:dnd_character_creator/Screens/dnd_forms/specifics_selection.dart';
import 'package:dnd_character_creator/Widgets/dnd_form_widgets/class_data_loader.dart';
import 'package:dnd_character_creator/Widgets/buttons/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:dnd_character_creator/widgets/buttons/button_with_padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClassSelection extends StatefulWidget {
  final String characterName; // Add characterName parameter

  const ClassSelection({Key? key, required this.characterName}) : super(key: key); // Update constructor

  @override
  _ClassSelectionState createState() => _ClassSelectionState();
}

class _ClassSelectionState extends State<ClassSelection> {
  String selectedClassName = 'Sorcerer'; // Default class

  // Method to save the selected class to Firebase
  void _saveSelections() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle user not being authenticated
      print('User not authenticated');
      return;
    }
    final userId = user.uid;

    final docRef = FirebaseFirestore.instance
        .collection('app_user_profiles')
        .doc(userId); // Use the authenticated user's ID

    try {
      await docRef.set({
        'class': selectedClassName,
      }, SetOptions(merge: true)); // Merge ensures only this field is updated
    } catch (e) {
      print('Error saving class: $e');
    }
  }

  // Updates the selected class and calls setState
  void updateSelectedClass(String className) {
    setState(() {
      selectedClassName = className;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavigationButton(
              textContent: "Back",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            NavigationButton(
              textContent: 'Next',
              onPressed: () {
                _saveSelections(); // Save class selection before navigating
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpecificsScreen(
                      characterName: widget.characterName, // Pass characterName
                      className: selectedClassName,       // Pass selected class name
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Class Selection for ${widget.characterName}', // Use characterName here
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          const Text(
            'Pick your class',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10, // Space between buttons
            runSpacing: 10, // Space between rows
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
        ],
      ),
    );
  }
}