import 'package:flutter/material.dart';
import 'package:dnd_character_creator/Data/background_data.dart';
import 'package:dnd_character_creator/Screens/stats_screen.dart';
import 'package:dnd_character_creator/Widgets/main_drawer.dart';
import 'package:dnd_character_creator/Widgets/background_data_loader.dart';
import 'package:dnd_character_creator/Widgets/button_with_padding.dart';
import 'package:dnd_character_creator/Widgets/navigation_button.dart';

class SpecificsScreen extends StatefulWidget {
  const SpecificsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SpecificsScreenState();
  }
}

class _SpecificsScreenState extends State<SpecificsScreen> {
  final backgrounds = BackgroundData;
  final List<String> proficiencies = ['Stealth', 'Persuasion', 'Athletics'];
  final List<String> languages = ['Elvish', 'Dwarvish', 'Common'];
  final Color customColor = const Color.fromARGB(255, 138, 28, 20);

  String _selectedBackground = 'Acolyte';
  String _selectedProficiency = 'Stealth';
  String _selectedLanguage = 'Elvish';

  String _currentSection =
      'Background'; // Track which section is currently active

  @override
  void initState() {
    super.initState();
    // Set initial content for the "Background" section
    setMainContent('Background');
  }

  void setMainContent(String type) {
    setState(() {
      _currentSection = type; // Update active section
    });
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StatsScreen()),
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
          IndexedStack(
            index: _getIndexForMainContent(),
            children: [
              Column(
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
              ),
              Column(
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
              ),
              Column(
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _getIndexForMainContent() {
    if (_currentSection == 'Background') {
      return 0;
    } else if (_currentSection == 'Proficiency') {
      return 1;
    } else {
      return 2;
    }
  }
}
