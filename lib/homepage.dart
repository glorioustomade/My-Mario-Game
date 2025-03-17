
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mario_game/button.dart';
import 'package:mario_game/jumpingmario.dart';
import 'package:mario_game/mario.dart';
import 'package:mario_game/shrooms.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double marioSize = 50;
  double shroomX = 0.5;
  double shroomY = 1;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midrun = false;
  bool midjump = false; 
  TextStyle gameFont = TextStyle(
     fontFamily: 'pressstart2p',
  color: Colors.white,
  fontSize: 20,
  );

void checkIfAteShrooms(){
   if ((marioX - shroomX). abs() < 0.05 && (marioY - shroomY).abs() < 0.05){
    setState(() {
      // if eatem, move the shroom off the screen
      shroomX = 2;
      marioSize = 100;
    });
   }
}
  void preJump(){
    time = 0;
    initialHeight = marioY; 
  }


void jump(){
  // this first if statement disables the double jump
  if (midjump == false){
    midjump = true;
  preJump();
  Timer.periodic(Duration(milliseconds: 50), (timer){
    time += 0.05;
    height = -4.9 * time * time + 5 * time ;

    if (initialHeight - height > 1 ){
      midjump = false;
      setState(() {
      marioY = 1;
      });
      timer.cancel(); 
   
    }else{
    setState(() {
      marioY = initialHeight -  height;
    });
    }
  }); 
  }
}


void moveRight(){
  direction = "right";
  checkIfAteShrooms();
  Timer.periodic(Duration(milliseconds: 50), (timer){
    checkIfAteShrooms();
    if (MyButton().userIsHoldingButton()== true &&( marioX + 0.02) < 1){
      setState(() {
        marioX +=0.02;
        midrun = !midrun;
      });
    }else{
      timer.cancel();
    }
  });

}
void moveLeft(){
  direction ="left";
  checkIfAteShrooms();
  Timer.periodic(Duration(milliseconds: 50), (timer){
    checkIfAteShrooms();
    if (MyButton().userIsHoldingButton()== true &&( marioX - 0.02) > -1){
      setState(() {
        marioX -=0.02;
        midrun = !midrun;
      });
    }else{
      timer.cancel();
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
              color: Colors.blue,
              
              child: AnimatedContainer(
                alignment: Alignment(marioX, marioY),
                duration: Duration(microseconds: 0),
              child: midjump 
              ? JumpingMario(
                direction: direction,
                size: marioSize,
              ):
              MyMario(
                direction: direction,
                 midrun : midrun,
                 size: marioSize,
              ),
              ),
              
              ),

              Container(
                alignment: Alignment(shroomX, shroomY),
                child: MyShroom(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('MARIO', style: gameFont,),
                        SizedBox(height: 10,),
                        Text('0000', style: gameFont,)
                      ],
                    ),
                     Column(
                      children: [
                        Text('WORLD', style: gameFont,),
                        SizedBox(height: 10,),
                        Text('1-1', style: gameFont,)
                      ],
                    ),
                     Column(
                      children: [
                        Text('TIME', style: gameFont,),
                        SizedBox(height: 10,),
                        Text('9999', style: gameFont,)
                      ],
                    ),
                  ],
                
                ),
              )
              ],
            )
              ),
              Expanded(
                flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    child: Icon(Icons.arrow_back, color: Colors.white,),
                    function: moveLeft,
                  ),
                 MyButton(
                    child: Icon(Icons.arrow_upward, color: Colors.white,),
                    function: jump,
                  ),
                  MyButton(
                    child: Icon(Icons.arrow_forward, color: Colors.white,),
                    function: moveRight,
                  ),
                ],
              ),
              ),
              )
        ],
      ),
    );
  }
}