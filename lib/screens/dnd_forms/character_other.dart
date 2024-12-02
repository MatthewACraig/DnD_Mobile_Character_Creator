import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class CharacterOther extends StatefulWidget {
  @override
  State<CharacterOther> createState() => _CharacterOtherState();
}

class _CharacterOtherState extends State<CharacterOther> {
  Color customColor = const Color.fromARGB(255, 138, 28, 20);
//TODO: Fetch from firestore
  final chosenlifeStyle = 'Wealthy';
  final chosenAlignment = 'Lawful Good';
  final chosenFaith = 'Flat Earther';
  final chosenLanguages = ['Common', 'Dwarvish', 'Elvish'];
  final chosenHair = 'Brown';
  final chosenEyes = 'Brown';
  final chosenSkin = 'White';
  final chosenHeight = '5\'10"';
  final chosenWeight = '150 lbs';
  final chosenAge = '25';
  final chosenGender = 'Male';
  final chosenPersonality = 'Aggressive';
  final chosenIdeals = 'Justice';
  final chosenBonds = 'Family';
  final chosenFlaws = 'Frogs are very scary. Whenever I see a frog jump into a lake full of frogs I cry. Avoid frogs at all costs';
  final chosenOrganizations = 'Marching Band';
  final chosenAllies = 'The french horn paleyers';
  final chosenEnemies = 'Trumpets and football players';
  final chosenBackstory = 'I was once a frog.';
  final everythingElse = 'I have no idea what I am doing.';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Divider(color: Colors.black, thickness: 2),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 25),
              const Text(
                "Lifestyle",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: Text(
                  '.............................................',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(chosenlifeStyle,
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              const SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 25),
              const Text(
                "Alignment",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: Text(
                  '..........................................',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(chosenAlignment,
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              const SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 25),
              const Text(
                "Faith",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: Text(
                  '.............................................',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(chosenFaith,
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              const SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.black, thickness: 2),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 25),
              Text(
                "Languages",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: 75,
            width: 375,
            child: SingleChildScrollView(
              child: Text(chosenLanguages.join(', '),
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ),

          const SizedBox(height: 10),
          const Divider(color: Colors.black, thickness: 2),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 25),
              const Text(
                "Hair",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: Text(
                  '.............................................',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(chosenHair,
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              const SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 25),
              const Text(
                "Eyes",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: Text(
                  '..........................................',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(chosenEyes,
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              const SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 25),
              const Text(
                "Skin",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: Text(
                  '.............................................',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(chosenSkin,
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              const SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 25),
              const Text(
                "Height",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: Text(
                  '.............................................',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(chosenHeight,
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              const SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 25),
              const Text(
                "Weight",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: Text(
                  '.............................................',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(chosenWeight,
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              const SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 25),
              const Text(
                "Age",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: Text(
                  '.............................................',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(chosenAge,
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              const SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 25),
              const Text(
                "Gender",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: Text(
                  '.............................................',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(chosenGender,
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              const SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.black, thickness: 2),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 25),
              Text(
                "Personality",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: 150,
            width: 375,
            child: SingleChildScrollView(
              child: Text(chosenPersonality,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 25),
              Text(
                "Ideals",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: 150,
            width: 375,
            child: SingleChildScrollView(
              child: Text(chosenIdeals,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 25),
              Text(
                "Bonds",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: 150,
            width: 375,
            child: SingleChildScrollView(
              child: Text(chosenBonds,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 25),
              Text(
                "Flaws",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: 150,
            width: 375,
            child: SingleChildScrollView(
              child: Text(chosenFlaws,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.black, thickness: 2),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 25),
              Text(
                "Organizations",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: 150,
            width: 375,
            child: SingleChildScrollView(
              child: Text(chosenOrganizations,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 25),
              Text(
                "Allies",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: 150,
            width: 375,
            child: SingleChildScrollView(
              child: Text(chosenAllies,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 25),
              Text(
                "Enemies",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: 150,
            width: 375,
            child: SingleChildScrollView(
              child: Text(chosenEnemies,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 25),
              Text(
                "Backstory",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: 150,
            width: 375,
            child: SingleChildScrollView(
              child: Text(chosenBackstory,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 25),
              Text(
                "Other Notes",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            height: 150,
            width: 375,
            child: SingleChildScrollView(
              child: Text(everythingElse,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
