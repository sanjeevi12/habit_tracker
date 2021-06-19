import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskCompletionRing extends StatelessWidget {
  final double progress;

  const TaskCompletionRing({Key? key, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context);
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: RingPainter(
            circleColor: colorTheme.taskRing,
            foreGroundColor: colorTheme.accent,
            progress: progress),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final Color circleColor;
  final Color foreGroundColor;
  final double progress;

  RingPainter(
      {required this.circleColor,
      required this.foreGroundColor,
      required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    print('$size');
    final hasCompleted = progress < 1;
    final strokeWidth = size.width / 15;
    final center = Offset(size.height / 2, size.width / 2);
    final radius =
        hasCompleted ? (size.width - strokeWidth) / 2 : size.width / 2;
    if (hasCompleted) {
      final circlePainter = Paint()
        ..isAntiAlias = true
        ..color = circleColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, circlePainter);
    }

    final foregroundPainter = Paint()
      ..isAntiAlias = true
      ..color = foreGroundColor
      ..strokeWidth = strokeWidth
      ..style = hasCompleted ? PaintingStyle.stroke : PaintingStyle.fill;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        2 * pi * progress, false, foregroundPainter);
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
