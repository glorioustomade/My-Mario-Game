import 'package:flutter/material.dart';

class MyShroom extends StatelessWidget {
  const MyShroom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      child: Image.asset('lib/images/mushroom.png'),
    );
  }
}