import 'package:esp_iot/esp_data_page.dart';
import 'package:esp_iot/meteo_page.dart';
import 'package:esp_iot/wigets/buttons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ESP IOT",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 15,
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            spacing: 5,
            children: [
              MeteoPage(height: 200,),
              EspDataPage(),
              Expanded(child: ArrozeButton()),
              const SizedBox(height: 10,)
            ],
          ),
      ),
    );
  }
}