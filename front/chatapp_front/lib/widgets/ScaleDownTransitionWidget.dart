import 'package:flutter/material.dart';

class ScaleDownTransitionWidget extends StatelessWidget {
  final Widget child;
  final double minSize;
  // ignore: prefer_const_constructors_in_immutables
  ScaleDownTransitionWidget(
      {super.key, required this.child, this.minSize = 0.9});

  late final AnimationController animationController;

  void onPressed() async {
    if (!animationController.isAnimating) {
      // ignore: avoid_print
      print("<<<<<<<<<<<Start Animation>>>>>>>>>>>");
      await animationController.forward();
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 200),
    );

    return Listener(
      onPointerDown: (event) => onPressed(),
      onPointerUp: (event) => onPressed(),
      child: ScaleTransition(
        scale: Tween<double>(begin: 1, end: minSize).animate(
          animationController,
        ),
        child: child,
      ),
    );
  
  }
}
// class ScaleZoomTransitionWidget extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return cont
//   }

// }