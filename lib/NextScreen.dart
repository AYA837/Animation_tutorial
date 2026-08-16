// ignore_for_file: file_names

import 'package:flutter/material.dart';
//hello world

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tween Animation Builder"),
        backgroundColor: Colors.blue,
      ),

      //we will be implmenting tween in this page
      //tween animates according to a given  starting point and an ending point

      body: Center(
        child: TweenAnimationBuilder(
          tween: IntTween(begin: 3 , end: 0), //tween class  is a generic class '"template based class" and needs to be provided a valid data type
                                               //for both the end and start to make sure they have the same datatype :)
          
          duration: const Duration(seconds: 4),
          //the animation is done in such a way the builder is being called over and over again
          builder: (BuildContext context,int  value , child) {
            // ignore: avoid_print
            print("builder called for $value");
            return Text(
              value.toString(),
              style: _getTextStyle(),
            );
          } ,
        ),
      ),
    );
  }

  TextStyle _getTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 45,
      color: Colors.blue,
    );
  }
}
