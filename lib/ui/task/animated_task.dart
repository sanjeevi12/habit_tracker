import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  final String iconData;

  const AnimatedTask({Key? key, required this.iconData}) : super(key: key);
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
    if (status == AnimationStatus.completed) {
      setState(() {
        _showCheckIcon = true;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _showCheckIcon = false;
        });
      });
    }
  }

  void _onTapDown(TapDownDetails details) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    } else if (!_showCheckIcon) {
      _animationController.value = 0;
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
      onTapUp: (_)=> _onTapcancel(),
      onTapCancel:_onTapcancel,
      child: AnimatedBuilder(
          animation: _curvedAnimation,
          builder: (BuildContext context, Widget? child) {
            final themeData = AppTheme.of(context);
            final progress = _curvedAnimation.value;
            final hasCompleted = progress == 1;
            return Stack(
              children: [
                TaskCompletionRing(
                  progress: _curvedAnimation.value,
                ),
                Positioned.fill(
                    child: CenteredSvgIcon(
                  iconName: _showCheckIcon ? AppAssets.check : widget.iconData,
                  color: hasCompleted
                      ? themeData.accentNegative
                      : themeData.accent,
                ))
              ],
            );
          }),
    );
  } 
}
