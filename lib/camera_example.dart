import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/long_press_bloc.dart';
import 'package:flutter_animation/capture_button.dart';
import 'package:flutter_animation/circle_progress_bar.dart';
import 'package:flutter_animation/long_press_bloc.dart';
import 'package:flutter_animation/long_press_event_counter.dart';
import 'package:flutter_animation/main.dart';
import 'package:path_provider/path_provider.dart';


class CameraExampleHome extends StatefulWidget {
  List<CameraDescription> cameras;

  CameraExampleHome(this.cameras) : assert(cameras != null);

  @override
  _CameraExampleHomeState createState() {
    return _CameraExampleHomeState();
  }
}

/*
/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}*/

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _CameraExampleHomeState extends State<CameraExampleHome> {
  CameraController controller;

  //String imagePath;
  String videoPath;

  //VideoPlayerController videoController;
  //VoidCallback videoPlayerListener;
  Future<void> _initializeControllerFuture;
  int cameraIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LongPressBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setUpCamera();
    _bloc = LongPressBloc();
  }

  Future<void> _setUpCamera() async {
    try {
      //ImageSource source = ImageSource.camera;
      controller = CameraController(
          widget.cameras[cameraIndex], ResolutionPreset.medium);
      /*
      initialize() is used to decide the best size for preview and pic, and set up all relative characteristics.
      Once it's done, and the surfacetexture is available, open camera and start preview from native side.
      retain textureId and give it to flutter Texture to show the preview
       */
      _initializeControllerFuture = controller.initialize();
    } on CameraException catch (e) {
      //todo
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Camera example'),
      ),
      body: new Stack(
        //alignment: const Alignment(1, -1),
        children: <Widget>[
          Container(
            child: _cameraPreviewWidget(),
          ),
          _cameraTogglesRowWidget(),
          _captureControlRowWidget(),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    return new FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(controller);  // create texture view to show the preview
              AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  /// Display the thumbnail of the captured image or video.
  /*
  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: videoController == null || videoPath == null
            ? null
            : SizedBox(
                child: Container(
                  child: Center(
                    child: AspectRatio(
                        aspectRatio: videoController.value.size != null
                            ? videoController.value.aspectRatio
                            : 1.0,
                        child: VideoPlayer(videoController)),
                  ),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.pink)),
                ),
                width: 64.0,
                height: 64.0,
              ),
      ),
    );
  }*/

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return new FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            return Center(
             child: GestureDetector(
               onLongPress: onVideoButtonPressed,//()=>_bloc.counterEventSink.add(LongPressStartEvent()),//
               onLongPressUp: onVideoButtonPressed,//()=>_bloc.counterEventSink.add(LongPressEndEvent()),//
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
             ),
            );
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }


  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];
    if (widget.cameras.isEmpty) {
      return const Text('No camera found');
    }
    return new Container(
        child: IconButton(
          onPressed: () {
            cameraIndex < widget.cameras.length - 1
                ? cameraIndex++
                : cameraIndex = 0;
            CameraDescription camera = widget.cameras[cameraIndex];
            controller != null && controller.value.isRecordingVideo
                ? null
                : onNewCameraSelected(camera);
          },
          icon: Icon(Icons.switch_camera),
        ));
    /*
    else if(widget.cameras.length > 1){
        return new Container(
          child: IconButton(
            onPressed: (){
              cameraIndex < widget.cameras.length-1?cameraIndex++:cameraIndex = 0;
              CameraDescription camera = widget.cameras[cameraIndex];
              if(controller==null || !controller.value.isRecordingVideo){
                onNewCameraSelected(camera);
              }
            },
            icon: Icon(Icons.switch_camera),
          )
        );
      }*/
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.medium);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onVideoButtonPressed(){
    if(controller != null && controller.value.isInitialized){
      if(!controller.value.isRecordingVideo){
        startVideoRecording();
      }else{
        stopVideoRecording();
      }
    }
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).


/*
  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          videoController?.dispose();
          videoController = null;
        });
        if (filePath != null) showInSnackBar('Picture saved to $filePath');
      }
    });
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording();
        /*.then((String filePath) {
      if (mounted) setState(() {});
      // if (filePath != null) showInSnackBar('Saving video to $filePath');
    });*/
  }

  void onStopButtonPressed() {
    stopVideoRecording();
        /*.then((_) {
      if (mounted) setState(() {});
      //showInSnackBar('Video recorded to: $videoPath');
    });*/
  }*/

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Please wait for the camera to load');
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    /*
    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }*/

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath).then((_){
        _bloc.counterEventSink.add(LongPressStartEvent());
      });

    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording().then((_){
        _bloc.counterEventSink.add(LongPressEndEvent());
        navigateToPublishRepair();
      });
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    //await _startVideoPlayer();
  }

  void navigateToPublishRepair() {
    Navigator.push(context, new MaterialPageRoute(
        builder: (context){
          return new MyHomePage(videoPath: videoPath,);
        }));
  }

  /*
  Future<void> _startVideoPlayer() async {
    final VideoPlayerController vcontroller =
        VideoPlayerController.file(File(videoPath));
    videoPlayerListener = () {
      if (videoController != null && videoController.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) setState(() {});
        videoController.removeListener(videoPlayerListener);
      }
    };
    vcontroller.addListener(videoPlayerListener);
    await vcontroller.setLooping(true);
    await vcontroller.initialize();
    await videoController?.dispose();
    if (mounted) {
      setState(() {
        //imagePath = null;
        videoController = vcontroller;
      });
    }
    await vcontroller.play();
  }*/

  /*
  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }
*/
  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
/*

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraExampleHome(),
    );
  }
}

List<CameraDescription> cameras;

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(CameraApp());
}*/
