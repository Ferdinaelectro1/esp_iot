import 'package:esp_iot/wigets/box.dart';
import 'package:flutter/material.dart';

class MeteoPage extends StatelessWidget {
  final double? height;
  const MeteoPage({super.key,required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          spreadRadius: 2,
          offset: Offset(2, 4)
        )]
      ),
      child: Row(
        spacing: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        children:[ 
          Expanded(
            child: Container(
              alignment: Alignment.center,
              //color: Colors.red,
              padding: EdgeInsets.all(5),
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataBox(value: 30, icon: Icons.thermostat,unit: "°",size: 30,color: Colors.green,),
                  DataBox(value: 30, icon: Icons.water_drop,unit: "°",size: 30,color: Colors.green,),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Aujourd'hui",style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Image.asset("assets/icon/sunIcon.png",height: 90,),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              //color: Colors.green,
              padding: EdgeInsets.all(5),
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataBoxRow(
                    left: Image.asset("assets/icon/rain.png",
                    height: 45,), right: const Text("2h",style: TextStyle(fontSize: 25),),
                    spacing: 10,
                  ),
                  const Text("Rain",style: TextStyle(fontSize: 25),)
                ],
              ),
            ),
          )
        ]
      ),
    );
  }
}

