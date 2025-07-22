import 'package:flutter/material.dart';

class DataBox extends StatelessWidget {
  final double value;
  final IconData icon;
  final String? unit; 
  final double? size;
  final Color? color;
  
  const DataBox({
    super.key,
    required this.value, 
    required this.icon, 
    this.unit, 
    this.size,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,size: size,color: color,),
          const SizedBox(width: 10,),
          Text("$value $unit",style: TextStyle(fontSize: size),),
        ],
    );
  }
}

class DataBoxRow extends StatelessWidget {
  final Widget left;
  final Widget right;
  final double? spacing;
  const DataBoxRow({super.key,required this.left, required this.right,this.spacing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: spacing ?? 1,
      children: [
        left,
        right
      ],
    );
  }
}

class DataBoxContain extends StatelessWidget {
  final IconData icon;
  final String label;
  final String amount;
  final Color color;

  const DataBoxContain({
    super.key,
    required this.icon,
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.all(15),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: color,child:  Icon(icon, color: Colors.white, size: 28),),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              amount,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                //color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
