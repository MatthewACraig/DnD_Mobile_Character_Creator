import 'package:flutter/material.dart';
import 'package:dnd_character_creator/Screens/race_selection.dart';


class CharacterName extends StatefulWidget{
  const CharacterName({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CharacterNameState();
  }
}
class _CharacterNameState extends State<CharacterName>{
  String _characterName = '';

  void updateCharacterName(String name){
    setState(() {
      _characterName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Name'),
      ),
      body: Column(
        children: [
          Image(image: AssetImage('assets/DragonIcon.png')),
          const SizedBox(
            height: 15,
            width: 15,
          ),
          const Text(
            'Enter your character name:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 15,
            width: 15,
          ),
          TextField(
            onChanged: updateCharacterName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Character Name',
            ),
          ),
          const SizedBox(
            height: 15,
            width: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RaceSelection()));
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
      
    );
  }
}