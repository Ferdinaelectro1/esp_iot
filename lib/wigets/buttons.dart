import 'package:esp_iot/wigets/animated.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ArrozeButton extends StatefulWidget {
  const ArrozeButton({super.key});

  @override
  State<ArrozeButton> createState() => _ArrozeButtonState();
}

class _ArrozeButtonState extends State<ArrozeButton> {
  bool isarrose = false;

  Future<void> sendCommandToFireBase() async
  {
    final database = FirebaseDatabase.instance;
    final ref = database.ref("commandes");
    await ref.set({
    "ledState": isarrose,
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: isarrose ? AnimatedBox() : Center(
            child: Image.asset("assets/icon/can.png",height: 210,),
          ),
      ),
      onTap: () async {
        setState(() {
          isarrose = !isarrose;
        });
        await sendCommandToFireBase();
      } ,
    );
  }
}