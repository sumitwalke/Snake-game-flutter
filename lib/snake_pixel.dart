import 'package:flutter/material.dart';

class SnakePixel extends StatelessWidget {
  const SnakePixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),  
                ),
                // child: Text(index.toString(),style: const TextStyle(color: Colors.white),),
              ));
  }
}