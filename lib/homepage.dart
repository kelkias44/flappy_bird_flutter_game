import 'dart:async';

import 'package:flappy_bird/barrier.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;
  int score = 0; int highScore = 0;

  
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;
      });
      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });
      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }
    });
  }
  bool birdIsDead(){
    if (birdYAxis > 1 || birdYAxis < -1) {
      return true;
    }
    return false;
  }
  void resetGame(){
    Navigator.pop(context);
    setState(() {
      birdYAxis = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight = birdYAxis;
    });
  }
  void _showDialog(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: const Text(
            'GAME OVER',
            style: TextStyle(color: Colors.white),),
          content: Text('Score: $score',
                   style: const TextStyle(color: Colors.white),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  child: const Text('PLAY AGAIN',
                       style: TextStyle(color: Colors.brown)),
                ),
              ),     
          ),
          ],
        );
      });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Stack(children: [
              GestureDetector(
                onTap: () {
                  if (gameHasStarted) {
                    jump();
                  } else {
                    startGame();
                  }
                },
                child: AnimatedContainer(
                  alignment: Alignment(0, birdYAxis),
                  duration: const Duration(microseconds: 0),
                  color: Colors.blue,
                  child: const MyBird(),
                ),
              ),
              Container(
                alignment: const Alignment(0, -0.3),
                child: gameHasStarted
                    ? const Text('')
                    : const Text(
                        'T A P  T O  P L A Y',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                alignment: Alignment(barrierXone, 1.1),
                child: MyBarrier(
                  size: 150.0,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                alignment: Alignment(barrierXone, -1.1),
                child: MyBarrier(
                  size: 150.0,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                alignment: Alignment(barrierXtwo, 1.1),
                child: MyBarrier(
                  size: 100.0,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                alignment: Alignment(barrierXtwo, -1.1),
                child: MyBarrier(
                  size: 200.0,
                ),
              ),
            ]),
          ),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'Score',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '0',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'Best',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '10',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
