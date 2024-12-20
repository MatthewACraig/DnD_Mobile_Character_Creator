import 'package:dnd_character_creator/Widgets/buttons/navigation_button.dart';
import 'package:dnd_character_creator/Widgets/dnd_form_widgets/race_data_loader.dart';
import 'package:dnd_character_creator/widgets/dnd_form_widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:dnd_character_creator/Widgets/buttons/button_with_padding.dart';
import 'package:dnd_character_creator/Screens/dnd_forms/class_selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RaceSelection extends StatefulWidget {
  final String characterName; // Use characterName instead of characterID

  const RaceSelection(
      {super.key, required this.characterName}); // Update constructor

  @override
  _RaceSelectionState createState() => _RaceSelectionState();
}

class _RaceSelectionState extends State<RaceSelection> {
  String _selectedRace = 'Elf'; // Default race
  final Color customColor = const Color.fromARGB(255, 138, 28, 20);

  // Method to save the selected race to Firebase
  // void _saveSelections() async {
  //   final String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

  //   if (currentUserUid != null) {
  //     final docRef = FirebaseFirestore.instance
  //         .collection('app_user_profiles')
  //         .doc(currentUserUid); // Use the UID directly

  //     try {
  //       await docRef.set({
  //         'race': _selectedRace,
  //       }, SetOptions(merge: true)); // Merge ensures only this field is updated
  //     } catch (e) {
  //       print('Error saving race: $e');
  //     }
  //   }
  // }
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

      await docRef.set({
        'character name': widget.characterName,
      }, SetOptions(merge: true));
      await docRef.set({
        'character name' : widget.characterName,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data saved successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save data: $e")),
      );
    }
  }

  // Updates the selected race and calls setState
  void _updateSelectedRace(String raceName) {
    setState(() {
      _selectedRace = raceName;
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
            textContent: "Next",
            onPressed: () {
              _saveSelections();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassSelection(
                      characterName: widget.characterName,
                      race: _selectedRace), // Pass characterName
                ),
              );
            },
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: customColor,
        foregroundColor: Colors.white,
        title: Text(
          'Race Selection for ${widget.characterName}', // Use characterName here
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      drawer: MainDrawer(),
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
            spacing: 10,
            runSpacing: 10,
            children: [
              ButtonWithPadding(
                onPressed: () => _updateSelectedRace('Aasimar'),
                textContent: 'Aasimar',
              ),
              ButtonWithPadding(
                onPressed: () => _updateSelectedRace('Dragonborn'),
                textContent: 'Dragonborn',
              ),
              ButtonWithPadding(
                onPressed: () => _updateSelectedRace('Dwarf'),
                textContent: 'Dwarf',
              ),
              ButtonWithPadding(
                onPressed: () => _updateSelectedRace('Elf'),
                textContent: 'Elf',
              ),
              ButtonWithPadding(
                onPressed: () => _updateSelectedRace('Gnome'),
                textContent: 'Gnome',
              ),
              ButtonWithPadding(
                onPressed: () => _updateSelectedRace('Halfling'),
                textContent: 'Halfling',
              ),
              ButtonWithPadding(
                onPressed: () => _updateSelectedRace('Human'),
                textContent: 'Human',
              ),
              ButtonWithPadding(
                onPressed: () => _updateSelectedRace('Orc'),
                textContent: 'Orc',
              ),
              ButtonWithPadding(
                onPressed: () => _updateSelectedRace('Tiefling'),
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
                child: RaceDataLoader(raceName: _selectedRace),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
