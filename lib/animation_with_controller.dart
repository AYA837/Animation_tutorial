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

      //in this section we will be discovering what a stack is
      //a widget in flutter to overlap elements on top of each other
      body: Center(
        child: Column(
          children: [
            _stackWidget(),
            const SizedBox(height: 10),
            _buttonsController(),
          ],
        ),
      ),
    );
  }

  Widget _stackWidget() {
    //expanded makes the whatever element inside of it fill till it fit the needed space
    return const Expanded(
      child: Stack(
        children: [
          //align is a widget used to control where an element is positioned in flutter
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(radius: 35, backgroundColor: Colors.amber),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
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
        ElevatedButton(onPressed: () {}, child: const Text("Forward")),

        ElevatedButton(onPressed: () {}, child: const Text("Reverse")),

        ElevatedButton(onPressed: () {}, child: const Text("Stop")),

        ElevatedButton(onPressed: () {}, child: const Text("Reset")),

        ElevatedButton(onPressed: () {}, child: const Text("Repeat(reverse = false)")),

        ElevatedButton(onPressed: () {}, child: const Text("Repeat(reverse = true)")),
      ],
    );
  }
}
