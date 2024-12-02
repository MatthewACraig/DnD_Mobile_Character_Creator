import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_creator/models/character_item.dart';
import 'package:dnd_character_creator/screens/dnd_forms/character_loader_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dnd_character_creator/models/character.dart';
import 'package:dnd_character_creator/widgets/dnd_form_widgets/main_drawer.dart';

class UserCharacterScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _UserCharacterScreenState createState() => _UserCharacterScreenState();
}

class _UserCharacterScreenState extends State<UserCharacterScreen> {
  List<Character> characters = [];

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    final String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserUid != null) {
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('app_user_profiles')
            .doc(currentUserUid)
            .collection('characters')
            .get();

        final List<Character> loadedCharacters = [];
        for (var doc in querySnapshot.docs) {
          final data = doc.data();
          loadedCharacters.add(
            Character.fromMap(data),
          );
        }

        setState(() {
          characters = loadedCharacters;
        });
      } catch (e) {
        print('Error fetching characters: $e');
      }
    }
  }

  void removeCharacter(Character character) {
    final String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserUid != null) {
      try {
        FirebaseFirestore.instance
            .collection('app_user_profiles')
            .doc(currentUserUid)
            .collection('characters')
            .doc(character.name)
            .delete();

        setState(() {
          characters.remove(character);
        });
      } catch (e) {
        print('Error removing character: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Characters"),
      ),
      drawer: const MainDrawer(),
      body: characters.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: characters.length,
              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(characters[index].name),
                background: Container(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                ),
                onDismissed: (direction) {
                  removeCharacter(characters[index]);
                },
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterLoaderScreen(
                          characterName: characters[index].name,
                          characterBackground: characters[index].background,
                          characterClass: characters[index].characterClass,
                          characterRace: characters[index].race,
                          abilityScores: characters[index].abilityScores,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: characters[index].picture.isNotEmpty
                          ? Image.network(characters[index].picture,
                              width: 50, height: 50, fit: BoxFit.cover)
                          : const Icon(Icons.person, size: 50),
                      title: Text(characters[index].name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          '${characters[index].race} - ${characters[index].characterClass}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          removeCharacter(characters[index]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}



//working but ugly and unclickable
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dnd_character_creator/models/character.dart';
// import 'package:dnd_character_creator/widgets/dnd_form_widgets/main_drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserCharacterScreen extends StatefulWidget {
//   static const routeName = '/home';

//   @override
//   _UserCharacterScreenState createState() => _UserCharacterScreenState();
// }

// class _UserCharacterScreenState extends State<UserCharacterScreen> {
//   List<Character> characters = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchCharacters();
//   }

//   Future<void> fetchCharacters() async {
//     final String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
//     if (currentUserUid != null) {
//       try {
//         final querySnapshot = await FirebaseFirestore.instance
//             .collection('app_user_profiles')
//             .doc(currentUserUid)
//             .collection('characters')
//             .get();

//         final List<Character> loadedCharacters = [];
//         for (var doc in querySnapshot.docs) {
//           final data = doc.data();

//           // Safely access data, using default values if null
//           loadedCharacters.add(
//             Character(
//               name: data['name'] ?? 'Unknown',  // Default to 'Unknown' if null
//               race: data['race'] ?? 'Unknown',  // Default to 'Unknown' if null
//               characterClass: data['class'] ?? 'Unknown',  // Default to 'Unknown' if null
//               picture: data['picture'] ?? '',  // Default to empty string if null
//             ),
//           );
//         }

//         setState(() {
//           characters = loadedCharacters;
//         });
//       } catch (e) {
//         print('Error fetching characters: $e');
//       }
//     }
//   }

//   void removeCharacter(Character character) {
//     final String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
//     if (currentUserUid != null) {
//       try {
//         FirebaseFirestore.instance
//             .collection('app_user_profiles')
//             .doc(currentUserUid)
//             .collection('characters')
//             .doc(character.name)
//             .delete();

//         setState(() {
//           characters.remove(character);
//         });
//       } catch (e) {
//         print('Error removing character: $e');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Your Characters"),
//       ),
//       drawer: const MainDrawer(),
//       body: characters.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: characters.length,
//               itemBuilder: (ctx, index) => Dismissible(
//                 key: ValueKey(characters[index].name),
//                 background: Container(
//                   color: Theme.of(context).colorScheme.error.withOpacity(0.75),
//                   margin: const EdgeInsets.symmetric(horizontal: 16),
//                 ),
//                 onDismissed: (direction) {
//                   removeCharacter(characters[index]);
//                 },
//                 child: CharacterItem(character: characters[index]),
//               ),
//             ),
//     );
//   }
// }

// class CharacterItem extends StatelessWidget {
//   final Character character;

//   const CharacterItem({Key? key, required this.character}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: character.picture.isNotEmpty
//           ? Image.network(character.picture)
//           : const Icon(Icons.person),
//       title: Text(character.name),
//       subtitle: Text('${character.race} - ${character.characterClass}'),
//     );
//   }
// }




// //bees
// import 'package:dnd_character_creator/models/character_item.dart';
// import 'package:dnd_character_creator/widgets/dnd_form_widgets/main_drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:dnd_character_creator/models/character.dart';

// class UserCharacterScreen extends StatelessWidget {

//   static const routeName = '/home';

//   UserCharacterScreen({super.key});
//   void removeCharacter() {
//     //TODO: Remove character from firestore and characters list
//   }

//   //TODO: Fetch all characters for the user instead of hardcoded below
//   @override initState() {}

//   final List<Character> characters = [
//     Character(
//         name: 'Aragorn',
//         race: 'Human',
//         characterClass: 'Fighter',
//         picture:
//         'https://static.wikia.nocookie.net/book-of-heroes-and-villains/images/8/83/Aragorn.jpg/revision/latest?cb=20220425030645g'),
//     Character(
//         name: 'Gimli',
//         race: 'Dwarf',
//         characterClass: 'Barbarian',
//         picture:
//         'https://static.wikia.nocookie.net/pjmidearthfilms/images/5/5c/Imli.jpg/revision/latest?cb=20191231092916'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Your Characters")),
//       drawer: const MainDrawer(),
//       body: ListView.builder(
//         itemCount: characters.length,
//         itemBuilder: (ctx, index) => Dismissible(
//           key: ValueKey(characters[index]),
//           background: Container(
//             color: Theme.of(context).colorScheme.error.withOpacity(0.75),
//             margin: const EdgeInsets.symmetric(
//               horizontal: 16,
//             ),
//           ),
//           onDismissed: (direction) {
//             //TODO: Remove character
//             // removeCharacter(characters[index]);
//           },

//           child: CharacterItem(character: characters[index],),
//         ),
//       ),
//     );
//   }
// }