import 'package:flutter/material.dart';

class CaptureButton extends StatefulWidget{
  Size size;
  Color color;

  CaptureButton({this.size,this.color});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CaptureButtonWidget();
  }

}

class CaptureButtonWidget extends State<CaptureButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      width: widget.size.width,
      height: widget.size.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color,
      ),
    );
  }

  /*

   */
}