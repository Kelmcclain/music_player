import 'package:flutter/material.dart';

class ProgressBar extends CustomPainter {
  
  var progressBarColor;
  var songCompleted;


  ProgressBar(Color value, {this.progressBarColor,this.songCompleted});
  @override
  void paint(Canvas canvas, Size size) {
    var songProgressBar = Paint()
      ..color = progressBarColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
      var progressIndicator = Paint()
      ..color =Colors.deepOrange;

      var songProgressBarCompleted = Paint()
      ..color = Colors.deepOrange
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
      

    canvas.drawLine(Offset(size.width - size.width, 0),
        Offset(size.width, 0), songProgressBar);
        canvas.drawCircle(Offset(this.songCompleted, 0), 5.0, progressIndicator);
        canvas.drawLine(Offset(0, 0),
        Offset(this.songCompleted, 0), songProgressBarCompleted);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
