import 'dart:math';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  MyPainter({required this.progress, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * (progress / 100);

    final paint = Paint()
      ..color = Colors.greenAccent[700]!
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, paint);

    paint.color = Colors.white;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
