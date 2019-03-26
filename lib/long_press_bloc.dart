import 'dart:async';
import 'long_press_event_counter.dart';
import 'package:flutter/material.dart';

class LongPressBloc{
  Tween<Size> _bigBtnSizeTween,_smallBtnSizeTween;
  bool _showProgress;
  final _bigBtnStateController = StreamController<Tween<Size>>();
  final _smallBtnStateController = StreamController<Tween<Size>>();
  final _showProgressController = StreamController<bool>();
  Timer totalTimer;

  StreamSink<Tween<Size>> get _bigBtnSizeCounter => _bigBtnStateController.sink;

  Stream<Tween<Size>> get bigBtnSizeTween => _bigBtnStateController.stream;

  StreamSink<Tween<Size>> get _smallBtnSizeCounter => _smallBtnStateController.sink;

  Stream<Tween<Size>> get smallBtnSizeTween => _smallBtnStateController.stream;

  StreamSink<bool> get _showProgressCounter => _showProgressController.sink;

  Stream<bool> get showProgress => _showProgressController.stream;

  final _counterEventController = StreamController<CounterEvent>();

  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  LongPressBloc(){
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if(event is LongPressStartEvent){
      totalTimer = new Timer(new Duration(seconds:10), (){
        counterEventSink.add(new LongPressEndEvent());
      });
      _bigBtnSizeTween = Tween(begin:Size(70,70),end: Size(100, 100));
      _smallBtnSizeTween = Tween(begin:Size(50,50),end: Size(40, 40));
      _showProgress = true;
    } else{
      if(totalTimer!=null){
        totalTimer.cancel();
        totalTimer = null;
      }
      _bigBtnSizeTween = Tween(begin:Size(100, 100),end:Size(70,70));
      _smallBtnSizeTween = Tween(begin:Size(40, 40),end:Size(50,50));
      _showProgress = false;
    }
    _bigBtnSizeCounter.add(_bigBtnSizeTween);
    _smallBtnSizeCounter.add(_smallBtnSizeTween);
    _showProgressCounter.add(_showProgress);
  }

  void dispose(){
    _counterEventController.close();
    _bigBtnStateController.close();
    _smallBtnStateController.close();
    _showProgressController.close();
  }
}