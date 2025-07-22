import 'package:esp_iot/wigets/box.dart';
import 'package:flutter/material.dart';

class EspDataPage extends StatelessWidget {
  const EspDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: EdgeInsets.all(1),
      child: Row(
        children: [
          Expanded(child: DataBoxContain(icon: Icons.thermostat, label:"30 °C", amount: "", color: Colors.blue)),
          Expanded(child: DataBoxContain(icon: Icons.water_drop, label:"30 °C", amount: "", color: Colors.blue)),
          Expanded(child: DataBoxContain(icon: Icons.grass, label:"30 °C", amount: "", color: Colors.blue))
        ],
      ),
    );
  }
}