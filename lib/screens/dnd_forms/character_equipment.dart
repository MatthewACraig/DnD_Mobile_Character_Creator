import 'package:flutter/material.dart';
import 'package:dnd_character_creator/data/weapon_data.dart';
class CharacterEquipment extends StatefulWidget {
  const CharacterEquipment({Key? key}) : super(key: key);

  @override
  State<CharacterEquipment> createState() => _CharacterEquipmentState();
}

class _CharacterEquipmentState extends State<CharacterEquipment> {
  late String weapon1 = 'Club';
  late String weapon2 = 'Dagger';
  late String weapon3 = 'Rapier';
  late String weapon4 = 'Flail';

  final customColor = const Color.fromARGB(255, 138, 28, 20);


  final Map<String, IconData> weaponTypeIcons = {
    'bludgeoning': Icons.gavel,
    'piercing': Icons.sports_kabaddi,
    'slashing': Icons.cut,
    'special': Icons.star,
    'ammunition': Icons.architecture,
    '—': Icons.cancel, // No damage type
  };

  IconData getWeaponIcon(String damageType) {
    return weaponTypeIcons[damageType] ?? Icons.help; // Default to help icon if type is unknown
  }

  Map<String, dynamic>? getWeaponData(String weapon) {
    if (WeaponData.Weapons['SimpleWeapons']!.containsKey(weapon)) {
      return WeaponData.Weapons['SimpleWeapons']![weapon];
    }
    if (WeaponData.Weapons['MartialWeapons']!.containsKey(weapon)) {
      return WeaponData.Weapons['MartialWeapons']![weapon];
    }
    return null; // Weapon not found
  }

  Widget buildWeapon(String weapon) {
    final weaponData = getWeaponData(weapon) ?? {};
    final damageType = weaponData['damage_type'] ?? '—';

    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: Colors.black),
      ),
      height: 200,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weapon,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Icon(
            getWeaponIcon(damageType),
            size: 75,
            color: customColor,
          ),
          const SizedBox(height: 10),
          Text('Damage: ${weaponData['damage_die'] ?? 'N/A'}'),
          Text('Type: $damageType'),
          Text(
              'Properties: ${(weaponData['properties'] as List?)?.join(', ') ?? 'N/A'}', textAlign: TextAlign.center,),
        ],
      ),
    );
  }

  Widget buildRow(String one, String two) {
    return Row(
      children: [
        const Spacer(),
        buildWeapon(one),
        const SizedBox(width: 30),
        buildWeapon(two),
        const Spacer(),
      ],
    );
  }

  @override
  void initState() {
    // TODO: snag weapons from database
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildRow(weapon1, weapon2),
        const SizedBox(height: 30),
        buildRow(weapon3, weapon4),
      ],
    );
  }
}