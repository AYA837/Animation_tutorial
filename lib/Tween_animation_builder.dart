import 'package:flutter/material.dart';
       
class MyTween extends StatelessWidget {
 
  MyTween({super.key});

  double _dimension = 100;
  double _begin = 100;
  double _end = 300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tween Animation Builder"),
        backgroundColor: Colors.lightGreen,
      ),

      //we will be implmenting tween in this page
      //tween animates according to a given  starting point and an ending point
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 45),
            _containerWidget(),
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: () {},
              child: const Text("tween Builder Animation"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _NonrepeatedWidget() {
    return Container(child: Text("this is text", style: _getTextStyle()));
  }

  Widget _containerWidget() {
    //everytime the value changes the build is called again and whatever is inside of it is re-called too

    //i
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: _begin, end: _end),
      duration: const Duration(seconds: 2),

      //child is for widgets that do not need to be rebuilt everytime the animation changes
      child: _NonrepeatedWidget(),

      builder: (BuildContext context, double value, Widget? child) {
        return Container(
          height: value,
          width: value,
          decoration: _getBoxDecoration(),
          child: child,
        );
      },
    );
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(20),
    );

    //everytime the button is pressed the scafold is rebuilt over again with the new changes
  }

  TextStyle _getTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 45,
      color: Colors.white,
    );
  }
}
