import 'package:flutter/material.dart';

class AnimationWithController extends StatefulWidget {
  const AnimationWithController({super.key});

  @override
  State<AnimationWithController> createState() =>
      _AnimationWithControllerState();
}


//ticker Provider
//we will turn the 

class _AnimationWithControllerState extends State<AnimationWithController>
    with SingleTickerProviderStateMixin {
  //single ticker provider in case of using one animation controller only
  //late keyword
  //a variable that will have a value in the latter lines but will not be given the value now 

  //we will do that in the init state overriding
  late Animation<AlignmentGeometry> firstBallAnimation;
  late Animation<AlignmentGeometry> secondBallAnimation;

  //to control these animations we use animation Controller variable

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();


     _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      
      //reverse duration is the duration when the same animation happens from end to begin

      reverseDuration: const Duration(seconds: 1),

      );
  
    //the variables will be given values in the init state here


    firstBallAnimation = Tween<AlignmentGeometry>(begin: Alignment.topCenter , end: Alignment.bottomCenter ).animate(_animationController); 
    secondBallAnimation = Tween<AlignmentGeometry>(begin:Alignment.centerLeft  , end:Alignment.centerRight ).animate(_animationController);

    //controller controls the upper bound , lowerbound of the animation
    //by default they're 0 to 1 

    //it also controls the duration the animation happens in


   

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation With Controller"),
        backgroundColor: Colors.yellowAccent,
      ),

      //in this section we will be discovering what a stack is
      //a widget in flutter to overlap elements on top of each other
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            _stackWidget(),
            const SizedBox(height: 10),
            _buttonsController(),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Widget _stackWidget() {
    //expanded makes the whatever element inside of it fill till it fit the needed space
    return Expanded(
      child: Stack(
        children: [
          //align is a widget used to control where an element is positioned in flutter
          AlignTransition(
            alignment: firstBallAnimation,
            child: const CircleAvatar(radius: 35, backgroundColor: Colors.amber),
          ),
          AlignTransition(
            alignment: secondBallAnimation,
            child: const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.deepOrangeAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonsController() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        ElevatedButton(

          
          onPressed: ()=> _animationController.forward(), //animate from begin to end while continueing from the current positions
          child: const Text("Forward"),
        ),
      

        ElevatedButton(
          onPressed: () =>_animationController.reverse(), //animate from end to begin while continueing from the current positions
          child: const Text("Reverse"),
        ),
    

        ElevatedButton(
          onPressed: () =>_animationController.stop(), //interrupt the animation that's happening 
          child: const Text("Stop"),
        ),
        

        ElevatedButton(
          onPressed: () =>_animationController.reset(),
          child: const Text("Reset"),
        ),

        ElevatedButton(
          onPressed: () =>_animationController.repeat(reverse: false),
          child: const Text("Repeat(reverse = false)"),
        ),
    

        ElevatedButton(
          onPressed: () =>_animationController.repeat(reverse: true),
          child: const Text("Repeat(reverse = true)"),
        ),
      ],
    );
  }
}