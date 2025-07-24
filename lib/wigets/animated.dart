import 'package:flutter/material.dart';

class AnimatedBox extends StatefulWidget {
  const AnimatedBox({super.key});

  @override
  State<AnimatedBox> createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _rotation = Tween<double>(begin: 0, end: -0.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final String arrosoirAssets = "assets/icon/can.png";
  //final String arrosoirAssets = "https://cdn-icons-png.flaticon.com/512/9331/9331146.png";
 //  final String eauUrl = "https://cdn-icons-png.flaticon.com/512/3105/3105807.png";

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            AnimatedBuilder(
              animation: _rotation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotation.value,
                  child: child,
                );
              },
              child: Image.asset(arrosoirAssets, height: 210),
            ),
          ],
        ),
      );
  }
}