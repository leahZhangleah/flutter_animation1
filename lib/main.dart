import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/circle_progress_bar.dart';
import 'package:flutter_animation/long_press_bloc.dart';
import 'capture_button.dart';
import 'package:flutter_animation/long_press_event_counter.dart';
import 'camera_example.dart';
import 'package:flutter_animation/address/choose_address.dart';
import 'coupon/coupon.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.videoPath}) : super(key: key);
  final String title;
  String videoPath;
  String defaultString = 'waiting for the path';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bloc = LongPressBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('camera example'),
      ),
      body: new Column(
        children: <Widget>[
          RaisedButton(
            onPressed: ()async{
              List<CameraDescription> cameras =await availableCameras();
              Navigator.push(context, new MaterialPageRoute(builder: (context){return new Coupon();}));
            },
          ),
          Text(
            widget.videoPath?? widget.defaultString
          ),
        ],
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }
}
