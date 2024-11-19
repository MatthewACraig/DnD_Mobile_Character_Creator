import 'package:flutter/material.dart';

class EquipmentSelection extends StatefulWidget {
  const EquipmentSelection({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EquipmentSelectionState();
  }
}

class _EquipmentSelectionState extends State<EquipmentSelection> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment Selection'),
      ),
      body: Column(
        children: [
          Text('Select your equipment'),
          const SizedBox(
            height: 15,
            width: 15,
          ),
          
        ],
      ),
    );
  }
}
