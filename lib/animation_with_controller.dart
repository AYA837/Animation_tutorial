import 'package:flutter/material.dart';

class AnimationWithController extends StatefulWidget {
  const AnimationWithController({super.key});

  @override
  State<AnimationWithController> createState() =>
      _AnimationWithControllerState();
}

class _AnimationWithControllerState extends State<AnimationWithController>
    with SingleTickerProviderStateMixin {
  

  //a variable that will have a value in the latter lines but will not be given the value now 

  //we will do that in the init state overriding
  late Animation<AlignmentGeometry> firstBallAnimation;
  late Animation<AlignmentGeometry> secondBallAnimation;

  @override
  void initState() {
    super.initState();
    firstBallAnimation = Tween<AlignmentGeometry>(begin: Alignment.topCenter , end: Alignment.bottomCenter );
    secondBallAnimation = Tween<AlignmentGeometry>(begin:Alignment.centerLeft  , end:Alignment.centerRight );
   
  

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
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text("Forward"),
        ),
        const SizedBox(width: 10,),

        ElevatedButton(
          onPressed: () {},
          child: const Text("Reverse"),
        ),
        const SizedBox(width: 10,),

        ElevatedButton(
          onPressed: () {},
          child: const Text("Stop"),
        ),
        const SizedBox(width: 10,),

        ElevatedButton(
          onPressed: () {},
          child: const Text("Reset"),
        ),

        ElevatedButton(
          onPressed: () {},
          child: const Text("Repeat(reverse = false)"),
        ),
        const SizedBox(width: 10,),

        ElevatedButton(
          onPressed: () {},
          child: const Text("Repeat(reverse = true)"),
        ),
      ],
    );
  }
}