import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text('Animated Foo Basics'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _containerWidget(),
            const Spacer(),
            _buttonWidget(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _containerWidget() {
    return AnimatedContainer(
      
      //duration is needed in Animated-element 
      duration:const Duration(milliseconds: 200) ,
      width: _dimension,
      height: _dimension,
      decoration: _getBoxDecoration(),
      
    );
  }
   
   BoxDecoration _getBoxDecoration(){
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
}