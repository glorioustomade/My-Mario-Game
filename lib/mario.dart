import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
 
final direction;
final midrun;
final size;

const MyMario({this.direction, this.midrun, this.size});

  @override
  Widget build(BuildContext context) {
    if (direction == "right"){
      return Container(
      width: size,
      height: size,
      child: midrun? Image.asset('lib/images/supermairostanr.png'):
      Image.asset('lib/images/supermariorun.png'),
    );
    }else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
        width: size,
        height: size,
        child: midrun? Image.asset('lib/images/supermairostanr.png'):
                      Image.asset('lib/images/supermariorun.png'),
    ),
      );
    }
    
    
  }
}