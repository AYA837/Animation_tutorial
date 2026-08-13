import 'package:flutter/material.dart';


class AnimationWithController extends StatelessWidget {
  const AnimationWithController({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation With Controller"),
        backgroundColor: Colors.yellowAccent,
      ),

      //we will be implmenting tween in this page
      //tween animates according to a given  starting point and an ending point

    
    );
  }

 /* TextStyle _getTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 45,
      color: Colors.blue,
    );
  }*/
}
