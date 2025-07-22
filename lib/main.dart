import 'dart:async';

import 'package:esp_iot/home_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'ESP IOT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseReference _ref;
  final SepareBox = SizedBox(height: 20,);
  final _url = "http://192.168.0.32";

  Map<String,dynamic> datas = {
    "dht_temp": 0,
    "soil_hum": 0,
    "dht_hum": 0
  };

  @override
  void initState() {
    _ref = FirebaseDatabase.instance.ref("mesures");
    _ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if(data != null && data is Map)
      {
        //print(data);
        setState(() {
          datas["dht_temp"] = data["dht_temp"];   
          datas["soil_hum"] = data["soil_hum"];  
          datas["dht_hum"] = data["dht_hum"];  
        });
      }
    });
    super.initState();
  } 

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> sendMessage (BuildContext context) async
  {
    if(_url.isEmpty == false)
    {
      final url = "$_url/data";
      final dio = Dio();
      try
      {
        final response = await dio.get(url);
        if(response.statusCode == 200)
        {
          Map<String, dynamic> jsonData = response.data;
        setState(() {
          datas["dht_temp"] = jsonData["dht_temp"];
          datas["soil_hum"] = jsonData["soil_hum"];
          datas["dht_hum"] = jsonData["dht_hum"];
        });
       // print(response.toString());
        }
        else 
        {
          if(mounted)//vérifie si on est toujours dans le homepage avant d'afficher le message
          {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Erreur 404"),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            )
          );
          }
        }
      }
      catch(e)
      {
        if(mounted)//vérifie si on est toujours dans le homepage avant d'afficher le message
        {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Erreur lors de la communication avec le serveur"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          )
        );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
