import 'package:flutter/material.dart';
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
  _AnimatedTaskState createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curvedAnimation;
  bool _showCheckIcon = false;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 740));
    _animationController.value;
    _curvedAnimation =
        _animationController.drive(CurveTween(curve: Curves.easeInOut));
    _animationController.addStatusListener(_checkStatusListener);
    print(widget.completed);
    // _animationController.forward();
    // _animationController.addListener(() {
    //   setState(() {});
    // print('${_animationController.value'});
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController.removeStatusListener(_checkStatusListener);
    super.dispose();
  }

  void _checkStatusListener(AnimationStatus status) {
    print(widget.completed);
    if (status == AnimationStatus.completed) {
      widget.onCompleted?.call(true);

// widget.onCompleted!(true);
      // if(widget.onCompleted != null){
      //   // return true;
      //   widget.onCompleted!(true) ;
      // }
      if (mounted) {
        setState(() =>
          _showCheckIcon = true
        );
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
        _animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    } else if (!_showCheckIcon) {
      widget.onCompleted?.call(false);
      _animationController.value = 0.0;
    }
  }

  void _onTapcancel() {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
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
