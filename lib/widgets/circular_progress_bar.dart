import 'package:fitmate/utilis/custom_paint.dart';
import 'package:flutter/material.dart';


class CircularProgressBar extends StatefulWidget {
  const CircularProgressBar({super.key});

  @override
  State<CircularProgressBar> createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar> {
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(progress: progress, strokeWidth: 4),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            '${(progress * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}