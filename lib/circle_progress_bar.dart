import 'package:flutter/material.dart';
import 'dart:math';
class CircleProgressBar extends StatefulWidget{
  final Color backgroundColor,foregroundColor;
  final double value;
  final Duration duration;
  final Widget container;

  CircleProgressBar({this.backgroundColor, @required this.foregroundColor,
    @required this.value,@required this.duration,@required this.container});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CircleProgressBarState();
  }

}

class CircleProgressBarState extends State<CircleProgressBar> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> valueTween;
  //Animation<double> curve;
  //Tween<Color> foregroundColorTween;
  @override
  void initState() {
    super.initState();
    valueTween = Tween<double>(begin: 0,end: widget.value);
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration);
    /*
    curve = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut);*/
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.backgroundColor;
    final foregroundColor = widget.foregroundColor;
    // TODO: implement build
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.container,
        builder:(context,child){
          //final foregroundColor = foregroundColorTween?.evaluate(curve)??widget.foregroundColor;
          return CustomPaint(
              child: child,
              foregroundPainter: CircleProgressBarPainter(
                  percentage: valueTween.evaluate(_controller),
                  foregroundColor: foregroundColor,
                  backgroundColor: backgroundColor)
          );
        },
      ),
    );
  }

  @override
  void didUpdateWidget(CircleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.value != oldWidget.value){
      //todo:change this behaviour
      //start from where it stops last time
      //double beginValue = valueTween?.evaluate(_controller)??oldWidget?.value??0;
      valueTween = Tween<double>(begin: 0.0,end: widget.value?? 1);
      _controller
        ..value = 0
      ..forward();
    }

    if(widget.duration != oldWidget.duration){
      _controller
      ..duration = widget.duration?? Duration(seconds: 15)
          ..value = 0
          ..forward();
    }

    /*
    foregroundColorTween = ColorTween(
      begin: oldWidget?.foregroundColor,
      end: widget.foregroundColor
    );*/
  }
}

class CircleProgressBarPainter extends CustomPainter {
  final double percentage, strokeWidth;
  final Color backgroundColor,foregroundColor;

  CircleProgressBarPainter({
    @required this.percentage,
    double strokeWidth,
    this.backgroundColor,
    @required this.foregroundColor}
      ):this.strokeWidth = strokeWidth?? 10;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Size constrainedSize = size - Offset(this.strokeWidth, this.strokeWidth);
    final shortestSide = min(constrainedSize.width, constrainedSize.height);

    final foregroundPaint = Paint()
    ..color = this.foregroundColor
    ..strokeWidth = this.strokeWidth
    ..strokeCap = StrokeCap.butt
    ..style = PaintingStyle.stroke;

    final radius = (shortestSide/2);
    final double startAngle = -(2 * pi * 0.25);
    final double sweepAngle = (2 * pi * (this.percentage??0));

    if(this.backgroundColor!=null){
      final backgroundPaint = Paint()
          ..color = this.backgroundColor
          ..strokeWidth = this.strokeWidth
          ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    canvas.drawArc(
        Rect.fromCircle(center: center,radius: radius),
        startAngle, sweepAngle, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBarPainter);
    return oldPainter.percentage != this.percentage ||
    oldPainter.backgroundColor != this.backgroundColor ||
    oldPainter.foregroundColor != this.foregroundColor ||
    oldPainter.strokeWidth != this.strokeWidth;
  }
}