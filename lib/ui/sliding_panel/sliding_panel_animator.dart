import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/animation/animation_controller.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel.dart';

class SlidingPanelAnimator extends StatefulWidget {
  const SlidingPanelAnimator(
      {Key? key, required this.child, required this.direction})
      : super(key: key);
  final SlideDirection direction;
  final Widget child;
  @override
  SlidingPanelAnimatorState createState() =>
      SlidingPanelAnimatorState(Duration(milliseconds: 200));
}

class SlidingPanelAnimatorState
    extends AnimationControllerState<SlidingPanelAnimator> {
  SlidingPanelAnimatorState(Duration duration) : super(duration);

  void slideIn() => animationController.forward();
  void slideOut() => animationController.reverse();

  double _getOffsetX(double screenWidth, double animationValue) {
    final startOffset = widget.direction == SlideDirection.rightToLeft?
    screenWidth-SlidingPanel.leftPanelFixedWidth: -SlidingPanel.leftPanelFixedWidth;
  //  return 0;
    return startOffset *(1.0 - animationValue);
  } 
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: SlidingPanel(child: widget.child,direction: widget.direction,),
      builder: (context, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        final animationValue = animationController.value ;
        if(animationValue == 0){
          return Container();
        }
        final offsetX = _getOffsetX(screenWidth, animationValue);
        return Transform.translate(
          offset: Offset(offsetX, 0),
          child: child
        );
      },
    );
  }
}
