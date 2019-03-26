import 'package:flutter/material.dart';

class CaptureButton extends StatefulWidget{
  Size defaultSize;
  Color color;
  Tween<Size> sizeTween;

  CaptureButton({this.defaultSize,@required this.color,@required this.sizeTween});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CaptureButtonWidget();
  }

}

class CaptureButtonWidget extends State<CaptureButton> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
    _controller.forward();

  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: new Container(),
      builder: (context,child){
        return new Container(
          child: child,
          width: widget.sizeTween?.evaluate(_controller)?.width?? widget.defaultSize.width,
          height: widget.sizeTween?.evaluate(_controller)?.height?? widget.defaultSize.height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /*

   */
}