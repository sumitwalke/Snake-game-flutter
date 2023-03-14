import 'dart:async';
import 'package:flutter/material.dart';

import 'blank_pixel.dart';
import 'food_pixel.dart';
import 'snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum snakeDirection {UP, DOWN, RIGHT, LEFT}

class _HomePageState extends State<HomePage> {

  var currentDirection = snakeDirection.RIGHT;

  //grid dimensions
  int rowSize = 10;
  int numberOfSqaures = 100;

  //snake position
  List <int> snakePos = [0,1,2];

  //food position
  int foodPos = 55;


  //on play pressed
   void startGame() {
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
        setState(() {
          moveSnake();
        });
     },
     );
  }

  void moveSnake(){
    switch (currentDirection) {
      case snakeDirection.DOWN:
        {
          //add head
          if (snakePos.last + rowSize > numberOfSqaures){
            snakePos.add(snakePos.last + rowSize - numberOfSqaures);
          }
          else {
            snakePos.add(snakePos.last+rowSize);
          }
          //remove tail
          snakePos.removeAt(0);
        }
        break;
      case snakeDirection.UP:
        {
          //add head
          if (snakePos.last - rowSize < 0){
            snakePos.add(snakePos.last - rowSize + numberOfSqaures);
          }
          else {
            snakePos.add(snakePos.last-rowSize);
          }
          //remove tail
          snakePos.removeAt(0);
        }
        break;
      case snakeDirection.RIGHT:
        { 
          //add head
          if (snakePos.last % rowSize == 9){
            snakePos.add(snakePos.last + 1 - rowSize);
          }
          else {
            snakePos.add(snakePos.last+1);
          }
          //remove tail
          snakePos.removeAt(0);
        }
        break;
      case snakeDirection.LEFT:
        { 
          //add head
          if (snakePos.last % rowSize == 0){
            snakePos.add(snakePos.last - 1 + rowSize);
          }
          else {
            snakePos.add(snakePos.last-1);
          }
          //remove tail
          snakePos.removeAt(0);  
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:  GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0 && currentDirection != snakeDirection.UP){
            currentDirection = snakeDirection.DOWN;
          }
          else if (details.delta.dy < 0 && currentDirection != snakeDirection.DOWN){
            currentDirection = snakeDirection.UP;
          }
        },

        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0 && currentDirection != snakeDirection.LEFT){
            currentDirection = snakeDirection.RIGHT;
          }
          else if (details.delta.dx < 0 && currentDirection != snakeDirection.RIGHT){
            currentDirection = snakeDirection. LEFT;
          }
        },
        child: Column(
          children: [
      
            //high score
            Expanded(child: 
            Container(
      
            )),
      
            //grid view
            Expanded(
              flex: 3,
              child: 
            GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowSize),
            itemCount: numberOfSqaures,
            physics: const NeverScrollableScrollPhysics(), itemBuilder: (context, index) {
              if(snakePos.contains(index)) {
                return const SnakePixel();
              } 
              else if (foodPos == index) {
                return const FoodPixel();
              } 
              else {
                return const BlankPixels();
              }
            },)),
      
            //start button
            Expanded(child: 
            Center(
              child: MaterialButton(onPressed: startGame,
              textColor: Colors.white,color: Colors.purple,padding: const EdgeInsets.all(20),child: const Text('Play'),
            ),
            ))
          ],
        ),
      ),
    );
  }
}

 