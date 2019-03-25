import 'dart:async';
import 'long_press_event_counter.dart';
import 'package:flutter/material.dart';

class LongPressBloc{
  List<Size> _sizes = [];
  final _counterStateController = StreamController<List<Size>>();

  StreamSink<List<Size>> get _inCounter => _counterStateController.sink;

  Stream<List<Size>> get sizes => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();

  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  LongPressBloc(){
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if(event is LongPressStartEvent){
      _sizes = [Size(100,100),Size(40,40)];
    } else{
      _sizes = [Size(70,70),Size(50,50)];
    }
    _inCounter.add(_sizes);
  }

  void dispose(){
    _counterEventController.close();
    _counterStateController.close();
  }
}