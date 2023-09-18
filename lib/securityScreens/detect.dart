import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class Detect extends StatefulWidget {
  @override
  _DetectState createState() => _DetectState();
}

class _DetectState extends State<Detect> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  bool isCameraInitialized = false;
  String apiEndpoint = "https://awagaman.onrender.com/detect_faces";

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);

    await cameraController.initialize();
    if (!mounted) return;

    setState(() {
      isCameraInitialized = true;
    });

    cameraController.startImageStream((CameraImage image) {
      if (cameraController != null &&
          cameraController.value.isStreamingImages) {
        // Convert the CameraImage to a JPEG Uint8List
        Uint8List frameBytes = _convertCameraImageToJPEG(image);

        // Send the frame to the API
        _sendFrameToAPI(frameBytes);
      }
    });
  }

  Uint8List _convertCameraImageToJPEG(CameraImage image) {
    int width = image.width;
    int height = image.height;
    img.Image convertedImage = img.Image(width: width, height: height);

    for (int planeIndex = 0; planeIndex < image.planes.length; planeIndex++) {
      if (planeIndex == 0) {
        // Y-plane (luma)
        for (int x = 0; x < width; x++) {
          for (int y = 0; y < height; y++) {
            int pixel = image.planes[planeIndex].bytes[y * width + x];
            // convertedImage.setPixel(x, y, img.(0, pixel, pixel, pixel));
          }
        }
      } else {
        // U/V-plane (chroma)
        // For demonstration purposes, we're not handling chroma planes here.
        // You can adapt this part to handle the U/V planes if needed.
      }
    }

    return Uint8List.fromList(img.encodeJpg(convertedImage));
  }

  Future<void> _sendFrameToAPI(Uint8List frameBytes) async {
    if (!isCameraInitialized) return;

    try {
      final response = await http.post(
        Uri.parse(apiEndpoint),
        body: frameBytes,
        headers: {
          "Content-Type": "image/jpeg",
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print("Error sending frame. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending frame: $e");
    }
  }

  @override
  void dispose() {
    cameraController?.stopImageStream();
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Camera Frame Sender'),
        ),
        body: Center(
          child: isCameraInitialized
              ? AspectRatio(
                  aspectRatio: cameraController.value.aspectRatio,
                  child: CameraPreview(cameraController),
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
