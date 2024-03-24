import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'profile.dart';

class CameraPage extends StatefulWidget {
  final Function(String) onPhotoCapture;
  final GlobalKey<ProfilePageState> profilePageKey;

  CameraPage({required this.onPhotoCapture, required this.profilePageKey});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    await _controller.initialize();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    print('Building CameraPage');
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            print('Capturing photo...');
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            print('Calling onPhotoCaptured with path: ${image.path}');

            // Handle the captured image
            widget.profilePageKey.currentState?.onPhotoCapture(image.path);
            await Future.delayed(Duration(seconds: 1));
            //Navigator.pop(context); // Close the camera page after capturing
          } catch (e) {
            print('Error capturing image: $e');
          }
        },
      ),
    );
  }
}
