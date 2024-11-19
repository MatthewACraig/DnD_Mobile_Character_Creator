import 'package:dnd_character_creator/screens/specifics_selection.dart';
import 'package:dnd_character_creator/widgets/dnd_form_widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_creator/widgets/loaders/background_data_loader.dart';
import 'package:dnd_character_creator/data/background_data.dart';
import 'package:dnd_character_creator/widgets/buttons/navigation_button.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key, required this.characterID});
  final int characterID;

  @override
  State<StatefulWidget> createState() {
    return _BackgroundScreenState();
  }
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  final backgrounds = BackgroundData;
  final Color customColor = const Color.fromARGB(255, 138, 28, 20);

  String _selectedBackground = 'Acolyte';

  // Method to save the selected background to Firestore
  Future<void> _saveSelections() async {
    // Get a reference to the Firestore collection for the specific character
    final characterRef = FirebaseFirestore.instance.collection('characters').doc(widget.characterID.toString());

    // Set the background data for the character
    await characterRef.set({
      'background': _selectedBackground,
    }, SetOptions(merge: true));  // Use merge to avoid overwriting existing data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Background"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const MainDrawer(),
      bottomNavigationBar: Row(
        children: [
          NavigationButton(
            onPressed: () {
              Navigator.pop(context);
            },
            textContent: 'Back',
          ),
          const SizedBox(width: 30),
          NavigationButton(
            textContent: "Next",
            onPressed: () {
              _saveSelections();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SpecificsScreen(characterID: widget.characterID)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Pick your background',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 350,
                child: Center(
                  child: DropdownButton<String>(
                    value: _selectedBackground,
                    items: backgrounds.keys
                        .map(
                          (background) => DropdownMenuItem(
                        value: background,
                        child: Text(background),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedBackground = value!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 500,
                  width: 350,
                  child: SingleChildScrollView(
                    child: BackgroundDataLoader(
                      backgroundName: _selectedBackground,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
