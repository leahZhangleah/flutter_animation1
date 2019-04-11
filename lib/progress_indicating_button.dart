import 'package:flutter/material.dart';
import 'package:flutter_animation/capture_button.dart';
import 'package:flutter_animation/circle_progress_bar.dart';
import 'package:flutter_animation/long_press_bloc.dart';
import 'package:flutter_animation/long_press_event_counter.dart';

class ProgressIndicatingButton extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return ProgressIndicatingButtonState();
  }
}

class ProgressIndicatingButtonState extends State<ProgressIndicatingButton> {
  final _bloc = LongPressBloc();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onLongPress: ()=> _bloc.counterEventSink.add(LongPressStartEvent()),
      onLongPressUp: ()=>_bloc.counterEventSink.add(LongPressEndEvent()),
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new StreamBuilder(
              stream: _bloc.bigBtnSizeTween,
              //initialData: SizeTween(begin:Size(70,70),end: Size(100, 100)),
              builder: (context,snapshot){
                return new CaptureButton(defaultSize:Size(70,70),color: Colors.grey,sizeTween: snapshot.data,);
              }),
          new StreamBuilder(
              stream: _bloc.smallBtnSizeTween,
              //initialData: SizeTween(begin:Size(50,50),end: Size(40, 40)),
              builder: (context,snapshot){
                return new CaptureButton(defaultSize:Size(50,50),color: Colors.white,sizeTween: snapshot.data,);
              }),
          new StreamBuilder(
              stream: _bloc.showProgress,
              initialData: false,
              builder: (context,snapshot){
                //todo: stop animation when data is false
                if(snapshot.data){
                  return new CircleProgressBar(
                    foregroundColor: Colors.greenAccent,
                    value: 1.0,
                    duration: Duration(seconds: 10),
                    container:new Container(),
                  );
                }
                return new Container();
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }
}