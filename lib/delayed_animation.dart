import 'dart:ui';

import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  Widget child;
  double startY;
  int animationDuration;
  DelayedAnimation(
      {required this.child,
      required this.startY,
      required this.animationDuration});

  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;

  @override
  void initState() {
    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    );
    animation.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final value = Curves.easeInOut.transform(animation.value);
          return Transform.translate(
            offset: Offset(0.0, lerpDouble(widget.startY, 0, value)!),
            child: widget.child,
          );
        });
  }
}
