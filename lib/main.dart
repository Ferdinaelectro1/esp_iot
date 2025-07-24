import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:esp_iot/home_page.dart';
import 'package:esp_iot/provider/change_notifier_data.dart';
import 'package:esp_iot/secret.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ChangeNotifierData(),
      child: const MyApp(),
    )
  );
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
  int count = 5;
  final SepareBox = SizedBox(height: 20,);
  final url = "https://api.openweathermap.org/data/2.5/weather?q=Cotonou&appid=$API_KEY&units=metric";
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.ref("mesures");

    if (kIsWeb) {
      // Pour le Web, pas d'écoute temps réel => lecture toutes les 10s
      getFirebaseData();

      timer = Timer.periodic(Duration(seconds: 3), (_) => getFirebaseData());
    } else {
      // Pour mobile, on utilise l'écoute temps réel (onValue)
      _ref.onValue.listen((event) {
        final data = event.snapshot.value;
        final provid = Provider.of<ChangeNotifierData>(context, listen: false);
        if (data != null && data is Map) {
          provid.espTemperature = (data["dht_temp"] as num).toDouble();
          provid.espHumidity = (data["dht_hum"] as num).toDouble();
          provid.espTerreHumidity = (data["soil_hum"] as num).toDouble();
        }
      });
      timer = Timer.periodic(Duration(seconds: 10), (_) => updateMeteo());
    }
  }

  void getFirebaseData() async {
    final snapshot = await _ref.get();
    final data = snapshot.value;
    if (data != null && data is Map) {
      final provid = Provider.of<ChangeNotifierData>(context, listen: false);
      provid.espTemperature = (data["dht_temp"] as num).toDouble();
      provid.espHumidity = (data["dht_hum"] as num).toDouble();
      provid.espTerreHumidity = (data["soil_hum"] as num).toDouble();
    }
    //mettre à jour la météo reel après 5 mis à jour de firebase
    if(count >= 5)
    {
      updateMeteo();
      count = 0;
    }
    count ++;
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void updateMeteo() async
  {
    final provid = Provider.of<ChangeNotifierData>(context,listen: false);
    final dio = Dio();

    try
    {
     Response response = await dio.get(url);
     if(response.data is Map<String,dynamic> )
     {
      Map<String,dynamic> json1 = response.data;
      Map<String,dynamic> json2 = json1["main"];
      provid.reelTemperature = json2["temp"];
      provid.reelHumidity = json2["humidity"];
     }
     //print(response.data);
    }
    on DioException catch(e)
    {
      if(mounted)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("erreur dio meteo : $e"),backgroundColor: Colors.red,)
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
