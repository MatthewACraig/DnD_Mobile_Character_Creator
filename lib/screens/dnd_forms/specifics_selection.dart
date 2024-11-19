import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_creator/Data/background_data.dart';
import 'package:dnd_character_creator/Widgets/dnd_form_widgets/main_drawer.dart';
import 'package:dnd_character_creator/Widgets/dnd_form_widgets/background_data_loader.dart';
import 'package:dnd_character_creator/Widgets/buttons/button_with_padding.dart';
import 'package:dnd_character_creator/Widgets/buttons/navigation_button.dart';
import 'package:dnd_character_creator/screens/dnd_forms/stats_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SpecificsScreen extends StatefulWidget {
  final String characterName;
  final String className; 
  final String raceName;

  const SpecificsScreen({super.key, required this.characterName, required this.className, required this.raceName});

  @override
  State<SpecificsScreen> createState() => _SpecificsScreenState();
}

class _SpecificsScreenState extends State<SpecificsScreen> {
  final Map<String, dynamic> backgrounds = BackgroundData;
  final List<String> proficiencies = [
    'Acrobatics',
    'Animal Handling',
    'Arcana',
    'Athletics',
    'History',
    'Insight',
    'Intimidation',
    'Investigation',
    'Medicine',
    'Nature',
    'Perception',
    'Performance',
    'Persuasion',
    'Religion',
    'Sleight of Hand',
    'Stealth',
    'Survival'
  ];
  List<String> languages = [
    'Undercommon',
    'Primordial',
    'Deep Speech',
    'Celestial',
    'Abyssal',
    'Halfling',
    'Infernal',
    'Dwarvish',
    'Gnomish',
    'Draconic',
    'Elvish',
    'Sylvan',
    'Common',
    'Goblin',
    'Giant',
    'Orc',
  ];

  String _selectedBackground = 'Acolyte';
  String _selectedProficiency = 'Stealth';
  String _selectedLanguage = 'Elvish';
  String _currentSection = 'Background';

  @override
  void initState() {
    super.initState();

    if (!backgrounds.containsKey(_selectedBackground)) {
      _selectedBackground = backgrounds.keys.first;
    }
    if (!proficiencies.contains(_selectedProficiency)) {
      _selectedProficiency = proficiencies.first;
    }
    if (!languages.contains(_selectedLanguage)) {
      _selectedLanguage = languages.first;
    }
  }

  void setMainContent(String type) {
    setState(() {
      _currentSection = type;
    });
  }

  // Save data to Firestore
  // Future<void> saveToFirestore() async {
  //   try {
  //     // Access Firestore
  //     final firestore = FirebaseFirestore.instance;

  //     // Reference to the document for this character
  //     final docRef = firestore.collection('characters').doc(widget.characterName);

  //     // Set the data
  //     await docRef.set({
  //       'race' : widget.raceName,
  //       'class': widget.className,
  //       'background': _selectedBackground,
  //       'proficiency': _selectedProficiency,
  //       'language': _selectedLanguage,
  //     });

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Data saved successfully!")),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Failed to save data: $e")),
  //     );
  //   }
  // }
  Future<void> saveToFirestore() async {
    //grab the current userID so we can save the data to the correct user
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle user not being authenticated
      print('User not authenticated');
      return;
    }
    final userId = user.uid;

    try {
      // Access Firestore
      final firestore = FirebaseFirestore.instance;

      // Reference to the document for this character
      final docRef = firestore.collection('app_user_profiles/${userId}/characters').doc(widget.characterName);

      // Set the data
      await docRef.set({
        'race' : widget.raceName,
        'class': widget.className,
        'background': _selectedBackground,
        'proficiency': _selectedProficiency,
        'language': _selectedLanguage,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Specifics"),
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
              // Save data to Firestore before moving to the next screen
              saveToFirestore();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatsScreen(),
                ),
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
              'Pick your background, proficiencies, and languages',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8.0,
            children: [
              ButtonWithPadding(
                onPressed: () => setMainContent('Background'),
                textContent: 'Background',
              ),
              ButtonWithPadding(
                onPressed: () => setMainContent('Proficiency'),
                textContent: 'Proficiencies',
              ),
              ButtonWithPadding(
                onPressed: () => setMainContent('Language'),
                textContent: 'Languages',
              ),
            ],
          ),
          const SizedBox(height: 35),
          Expanded(
            child: IndexedStack(
              index: _getIndexForMainContent(),
              children: [
                _buildBackgroundSection(),
                _buildProficiencySection(),
                _buildLanguageSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _getIndexForMainContent() {
    switch (_currentSection) {
      case 'Proficiency':
        return 1;
      case 'Language':
        return 2;
      default:
        return 0;
    }
  }

  Widget _buildBackgroundSection() {
    return Column(
      children: [
        Container(
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
            height: 400,
            width: 350,
            child: SingleChildScrollView(
              child: BackgroundDataLoader(
                backgroundName: _selectedBackground,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProficiencySection() {
    return Column(
      children: [
        DropdownButton<String>(
          value: _selectedProficiency,
          items: proficiencies.map((proficiency) {
            return DropdownMenuItem(
              value: proficiency,
              child: Text(proficiency),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedProficiency = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    return Column(
      children: [
        DropdownButton<String>(
          value: _selectedLanguage,
          items: languages.map((language) {
            return DropdownMenuItem(
              value: language,
              child: Text(language),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedLanguage = newValue!;
            });
          },
        ),
      ],
    );
  }
}
