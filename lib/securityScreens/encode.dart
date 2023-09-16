import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:get/get_connect/http/src/_http/_io/_file_decoder_io.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:avagaman/securityScreens/home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:convert/convert.dart';

class Encode extends StatefulWidget {
  Encode({
    super.key,
  });

  @override
  State<Encode> createState() => _EncodeState();
}

class _EncodeState extends State<Encode> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the camera
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () =>
          cameras.first, // Use the first camera if no front camera is found.
    );

    _cameraController = CameraController(
      frontCamera, // Use the front camera here
      ResolutionPreset.high,
    );

    return _cameraController.initialize();
  }

  Future<Uint8List> imageToBytes(String imagePath) async {
    img.Image? image = img.decodeImage(File(imagePath).readAsBytesSync());

    if (image != null) {
      Uint8List bytes = Uint8List.fromList(img.encodeJpg(image));
      return bytes;
    } else {
      throw Exception('Failed to load and encode the image.');
    }
  }

  Future<void> _captureAndUpload() async {
    try {
      await _initializeControllerFuture;

      // Capture a picture
      final XFile capturedImage = await _cameraController.takePicture();

      Uint8List imgBytes = await imageToBytes(capturedImage.path);

      // Prepare the data to be sent
      Map<String, String> data = {
        'text': 'Adam',
        // You can add more text data as needed
      };

      // Prepare the image file
      var uri = Uri.parse("https://awagaman.onrender.com/encode_face");
      var request = http.MultipartRequest('POST', uri)
        ..fields.addAll(data)
        ..files.add(http.MultipartFile.fromBytes(
          'image',
          imgBytes,
          filename: 'image.jpg',
          contentType: MediaType('image', 'jpeg'), // Adjust MIME type
        ));

      // Send the multipart request
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image and text sent successfully');
        await for (var chunk in response.stream.transform(utf8.decoder)) {
          print(chunk);
        }
      } else {
        print('Failed to send image and text');
        print('Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture and Send Image'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Enter Text',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _captureAndUpload,
            child: Text('Capture and Send'),
          ),
        ],
      ),
    );
  }
}
