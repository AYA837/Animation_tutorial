import 'package:flutter/material.dart';
import 'package:my_app/NextScreen.dart';
import 'package:my_app/Tween_animation_builder.dart';
import 'package:my_app/Tween_animation_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//external functions need to be inside the class always remember that

class _HomeScreenState extends State<HomeScreen> {
  //to control the dimension of the stupid element we built
  //everytime we press the button the width and height changes depending on what's inside the on pressed changes
  double _dimension = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Foo Basics') , backgroundColor: Colors.pink,),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _containerWidget(),
            const SizedBox(height: 45,),
            _buttonWidget(),
            const SizedBox(height: 30),

 
            ElevatedButton(
              // Within the `FirstRoute` widget:
              onPressed: () {

                //first time learning how to navigate from a page to another 
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const NextScreen(),
                  ),
                );
              },

              child:const Text("tween animation builder"),
            ),
            
            ElevatedButton(
              // Within the `FirstRoute` widget:
              onPressed: () {

                //first time learning how to navigate from a page to another 
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) =>  MyTween(),
                  ),
                );
              },

              child:const Text("tween animation builder"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerWidget() {
    return AnimatedContainer(
      //duration is needed in Animated-element
      duration: const Duration(seconds: 1),

      //the curves section is explained below , for now every animated widget takes a curve property to decide which shape to take when animating
      //the types of curves are available in the official website of the flutter curve classes

      //we can change the curve here depending on our desired use
      curve: Curves.linearToEaseOut,
      width: _dimension,
      height: _dimension,

      decoration: _getBoxDecoration(),
    );
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      color: Colors.pink,
      borderRadius: BorderRadius.circular(20),
    );
  }
  //everytime the button is pressed the scafold is rebuilt over again with the new changes

  Widget _buttonWidget() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _dimension = _dimension == 100 ? 200 : 100;
        });
      },
      child: const Text('Start Animation'),
    );
  }

  //Curves : the flutter does animation using a reflection of   a curve
  //linear curve that doesn't change the global shape of the animation
  //a non linear curve will make the  animation element take another shape
}
