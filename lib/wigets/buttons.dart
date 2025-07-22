import 'package:flutter/material.dart';

class ArrozeButton extends StatelessWidget {
  const ArrozeButton({super.key});

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
          child: Center(
            child: Image.asset("assets/icon/can.png",height: 210,),
          ),
      ),
      onTap: (){} ,
    );
  }
}