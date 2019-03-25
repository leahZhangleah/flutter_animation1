import 'dart:async';
import 'long_press_event_counter.dart';
import 'package:flutter/material.dart';

class LongPressBloc{
  Size _bigBtnSize,_smallBtnSize;
  final _bigBtnStateController = StreamController<Size>();
  final _smallBtnStateController = StreamController<Size>();
  Timer totalTimer,passedTimer;
  int timePassed;
  Stopwatch stopwatch;

  StreamSink<Size> get _bigBtnSizeCounter => _bigBtnStateController.sink;

  Stream<Size> get bigBtnSize => _bigBtnStateController.stream;

  StreamSink<Size> get _smallBtnSizeCounter => _smallBtnStateController.sink;

  Stream<Size> get smallBtnSize => _smallBtnStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();

  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  LongPressBloc(){
    _counterEventController.stream.listen(_mapEventToState);
    stopwatch = new Stopwatch();
  }

  void _mapEventToState(CounterEvent event) {
    if(event is LongPressStartEvent){
      totalTimer = new Timer(new Duration(seconds:5), (){
        counterEventSink.add(new LongPressEndEvent());
      });
      stopwatch.start();
      passedTimer = new Timer.periodic(new Duration(milliseconds: 500), (timer){
        print(stopwatch.elapsedMilliseconds);
      });
      _bigBtnSize = Size(100,100);
      _smallBtnSize = Size(40,40);
    } else{
      if(totalTimer!=null){
        totalTimer.cancel();
        totalTimer = null;
      }
      if(passedTimer!=null){
        passedTimer.cancel();
        passedTimer=null;
      }
      stopwatch..stop()..reset();
      _bigBtnSize = Size(70,70);
      _smallBtnSize = Size(50,50);
    }
    _bigBtnSizeCounter.add(_bigBtnSize);
    _smallBtnSizeCounter.add(_smallBtnSize);
  }

  void dispose(){
    _counterEventController.close();
    _bigBtnStateController.close();
    _smallBtnStateController.close();
  }
}