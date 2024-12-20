import 'package:dnd_character_creator/data/weapon_data.dart';
import 'package:flutter/material.dart';

class WeaponDataLoader extends StatelessWidget {
  const WeaponDataLoader(
      {super.key, required this.weaponName, required this.WeaponType});

  final String weaponName;
  final String WeaponType;

  @override
  Widget build(BuildContext context) {
    // String daggerDamageDie = WeaponData.Weapons["SimpleWeapons"]?["Dagger"]?["damage_die"] ?? "Unknown";
    
    final weaponData = WeaponData.Weapons[WeaponType]?[weaponName];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weaponName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          
          _buildAttributeRow(
              label: 'Damage Die',
              value: weaponData!['damage_die'] ?? 'N/A',
              icon: Icons.design_services),
          _buildAttributeRow(
              label: 'Gold Cost',
              value: weaponData['gold_cost'] ?? 'N/A',
              icon: Icons.monetization_on),
          _buildAttributeRow(
              label: 'Damage Type',
              value: weaponData['damage_type'] ?? 'N/A',
              icon: Icons.language),
          _buildAttributeRow(
              label: 'Properties',
              value: _listToString(weaponData['properties']),
              icon: Icons.construction),
          _buildAttributeRow(
              label: 'Weight',
              value: weaponData['weight'] ?? 'N/A',
              icon: Icons.shopping_bag),
        ],
      ),
    );
  }

  String _listToString(dynamic value) {
    if (value.isNotEmpty) {
      if (value is List) {
        return value.join(', ');
      }
      return value.toString();
    }
    return 'N/A';
  }

  Widget _buildAttributeRow({
    required String label,
    required String value,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) Icon(icon, size: 24.0),
          if (icon != null) const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (label != 'Description')
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                Text(
                  value,
                  softWrap: true,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
