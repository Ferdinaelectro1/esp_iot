import 'package:esp_iot/provider/change_notifier_data.dart';
import 'package:esp_iot/wigets/box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EspDataPage extends StatelessWidget {
  const EspDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Consumer<ChangeNotifierData>( builder: (context, value, child) => Container(
          padding: EdgeInsets.all(1),
          child: Row(
            children: [
              Expanded(child: DataBoxContain(icon: Icons.thermostat, label:"${value.espTemperature} °C", amount: "", color: Colors.blue)),
              Expanded(child: DataBoxContain(icon: Icons.water_drop, label:"${value.espHumidity} %", amount: "", color: Colors.blue)),
              Expanded(child: DataBoxContain(icon: Icons.grass, label:"${value.espTerreHumidity} %", amount: "", color: Colors.blue))
            ],
          ),
      ),
    );
  }
}