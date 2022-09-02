import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double size;

  MyBarrier({required this.size}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 5, color: const Color.fromARGB(255, 46, 125, 50)),
        borderRadius: const BorderRadius.all(Radius.circular(15))
      ),

    );
  }
}