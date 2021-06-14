
import 'package:flutter/material.dart';

class TaskCompletionRing extends StatefulWidget {
  @override
  _TaskCompletionRingState createState() => _TaskCompletionRingState();
}

class _TaskCompletionRingState extends State<TaskCompletionRing> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: RingPainter(),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('$size');
    final strokeWidth = size.width / 15;
    final center = Offset(size.height / 2, size.width / 2);
    final radius = (size.width - strokeWidth) / 2;
    final circlePainter = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, circlePainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
