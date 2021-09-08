import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/animation/animation_controller.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask(
      {Key? key,
      required this.iconData,
      required this.completed,
      this.onCompleted})
      : super(key: key);
  final String iconData;
  final bool completed;
  final ValueChanged<bool>? onCompleted;

  @override
  _AnimatedTaskState createState() => _AnimatedTaskState(Duration(milliseconds: 700));
}

class _AnimatedTaskState extends AnimationControllerState<AnimatedTask> {
  _AnimatedTaskState(Duration duration):super(duration);
  // late final AnimationController animationController;
  late final Animation<double> _curvedAnimation;
  bool _showCheckIcon = false;
  @override
  void initState() {
    super.initState();
    // animationController =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 740));
    // animationController.value;
    _curvedAnimation =
        animationController.drive(CurveTween(curve: Curves.easeInOut));
    animationController.addStatusListener(_checkStatusListener);
    print(widget.completed);
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController.removeStatusListener(_checkStatusListener);
    super.dispose();
  }

  void _checkStatusListener(AnimationStatus status) {
    print(widget.completed);
    if (status == AnimationStatus.completed) {
      widget.onCompleted?.call(true);
      if (mounted) {
        setState(() => _showCheckIcon = true);
      }
      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _showCheckIcon = false);
        }
      });
    }
  }

  void _onTapDown(TapDownDetails details) {
    if (!widget.completed &&
        animationController.status != AnimationStatus.completed) {
      animationController.forward();
    } else if (!_showCheckIcon) {
      widget.onCompleted?.call(false);
      animationController.value = 0.0;
    }
  }

  void _onTapcancel() {
    if (animationController.status != AnimationStatus.completed) {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: (_) => _onTapcancel(),
      onTapCancel: _onTapcancel,
      child: AnimatedBuilder(
          animation: _curvedAnimation,
          builder: (BuildContext context, Widget? child) {
            final themeData = AppTheme.of(context);
            // final progress = 1.0;
            final progress = widget.completed ? 1.0 : _curvedAnimation.value;
            final hasCompleted = progress == 1.0;
            final iconColor =
                hasCompleted ? themeData.accentNegative : themeData.accent;
            return Stack(
              children: [
                TaskCompletionRing(progress: progress),
                Positioned.fill(
                    child: CenteredSvgIcon(
                        iconName: hasCompleted && _showCheckIcon
                            ? AppAssets.check
                            : widget.iconData,
                        color: iconColor))
              ],
            );
          }),
    );
  }
}
