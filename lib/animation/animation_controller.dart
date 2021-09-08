import 'package:flutter/material.dart';

abstract class AnimationControllerState<T extends StatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  AnimationControllerState(this.animationDuration);
  final Duration animationDuration;
  late final animationController =
      AnimationController(duration: animationDuration, vsync: this);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
