// import 'dart:io';

// import 'package:avagaman/main.dart';
// import 'package:avagaman/utils/screen_mode.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// // import 'package:google_ml_barcode/google_ml_barcode.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:image_picker/image_picker.dart';

// class CameraView extends StatefulWidget {
//   final String title;
//   final CustomPainter? customPaint;
//   final String? text;
//   final Function(InputImage inputImage) onImage;
//   final CameraLensDirection initialDirection;

//   const CameraView({
//     Key? key,
//     required this.title,
//     required this.onImage,
//     required this.initialDirection,
//     this.customPaint,
//     this.text,
//   }) : super(key: key);

//   @override
//   State<CameraView> createState() => _CameraViewState();
// }

// class _CameraViewState extends State<CameraView> {
//   ScreenMode _mode = ScreenMode.live;
//   CameraController? _controller;
//   File? _image;
//   String? _path;
//   ImagePicker? _imagePicker;
//   int _cameraIndex = 0;
//   double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
//   final bool _allowPicker = true;
//   bool _changingCameraLens = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _imagePicker = ImagePicker();
//     if (cameras!.any(
//       (element) =>
//           element.lensDirection == widget.initialDirection &&
//           element.sensorOrientation == 90,
//     )) {
//       _cameraIndex = cameras!.indexOf(cameras!.firstWhere((element) =>
//           element.lensDirection == widget.initialDirection &&
//           element.sensorOrientation == 90));
//     } else {
//       _cameraIndex = cameras!.indexOf(cameras!.firstWhere(
//           (element) => element.lensDirection == widget.initialDirection));
//     }
//     _startLive();
//   }

//   Future _startLive() async {
//     final camera = cameras![_cameraIndex];
//     _controller =
//         CameraController(camera, ResolutionPreset.high, enableAudio: false);
//     _controller?.initialize().then((value) {
//       if (!mounted) {
//         return;
//       }
//       _controller?.getMaxZoomLevel().then((value) {
//         maxZoomLevel = value;
//         minZoomLevel = value;
//       });
//     });
//     _controller?.startImageStream(_processCameraImage);
//     setState(() {});
//   }

//   Future _processCameraImage(final CameraImage image) async {
//     final WriteBuffer allBytes = WriteBuffer();
//     for (final Plane plane in image.planes) {
//       allBytes.putUint8List(plane.bytes);
//     }
//     final bytes = allBytes.done().buffer.asUint8List();
//     final Size imageSize =
//         Size(image.width.toDouble(), image.height.toDouble());
//     final camera = cameras![_cameraIndex];
//     final imageRotation =
//         InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
//             InputImageRotation.rotation0deg;

//     final inputImageFormat =
//         InputImageFormatValue.fromRawValue(image.format.raw) ??
//             InputImageFormat.nv21;
//     final planeData = image.planes.map((final Plane plane) {
//       return InputImagePlaneMetadat` a(
//         bytesPerRow: plane.bytesPerRow,
//         height: plane.height,
//         width: plane.width,
//       );
//     }).toList();
//   }
//    final inputImageData=InputImageMetadata(
//     size:imageSize;
//    )
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:avagaman/securityScreens/home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Report extends StatefulWidget {
  Report({
    super.key,
  });

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image;

  // late CameraController _controller;
  // late Future<void> _initializeControllerFuture;
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    // late List<int> frameBytes;
    cameras = await availableCameras();
    if (cameras != null) {
      print("hello1");
      controller = CameraController(cameras![0], ResolutionPreset.max);
      // cameras[0] = first camera, change to 1 to another camera
      // await controller!.initialize();
      // await controller!.startImageStream((CameraImage image) {
      //   frameBytes = convertCameraImageToBytes(image);
      // });
      // frameBytes = frames();
        controller!.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
    } else {
      print("NO any camera found");
    }
    // } else {
    //   return [0, 0, 0, 0];
    // }
  }

  frames() {
    controller!.startImageStream((CameraImage image) {
      List<int> frameBytes;
      frameBytes = convertCameraImageToBytes(image);
      postByteStreamToApi(frameBytes, "202151149");
    });
    // Future.delayed(Duration(seconds: 5));
    // controller!.stopImageStream();
    // return frameBytes;
  }

  List<int> convertCameraImageToBytes(CameraImage image) {
    final Plane plane = image.planes[0];
    final bytes = Uint8List.fromList(plane.bytes);
    return bytes;
  }

  void postByteStreamToApi(List<int> byteStream, String textData) async {
    var apiUrl = Uri.parse('https://awagaman.onrender.com/encode_face');
    try {
      var request = http.MultipartRequest('POST', apiUrl);
      request.fields['text'] = textData;
      var imageFile = http.MultipartFile.fromBytes(
        'image',
        byteStream,
        filename: 'image.jpg', // Adjust the filename and MIME type as needed
        // contentType: ,
      );
      request.files.add(imageFile);
      var response = await request.send();
      //  String base64Encoded = base64Encode(byteStream);

      // Create the HTTP request
      // var response = await http.post(
      //   apiUrl,
      // data={
      //   'text'='202151149'
      // },

      // files:byteStream,
      // headers: {
      //   'Content-Type': 'application/octet-stream', // Set the content type to octet-stream
      // },
      // body: base64Encoded, // Send the base64-encoded byte stream as the request body
      // );

      if (response.statusCode == 200) {
        // Request was successful
        print('Successfully uploaded byte stream to the API.');
      } else {
        // Request failed
        print(
            'Failed to upload byte stream to the API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('Error: $e');
    }
  }
// Future<void> postFrameBytesToApiWithRetry(List<int> frameBytes, String textData) async {
//   int maxRetries = 3;
//   int retryCount = 0;

//   while (retryCount < maxRetries) {
//     try {
//       await postByteStreamToApi(frameBytes, textData);
//       break; // Request was successful, exit the loop
//     } catch (e) {
//       print('Error: $e');
//       retryCount++;
//       if (retryCount < maxRetries) {
//         // Wait for a moment before retrying
//         await Future.delayed(Duration(seconds: 2));
//       } else {
//         print('Maximum retries reached.');
//         break;
//       }
//     }
//   }
// }

  bool valueMetal = false;
  bool valuePaper = false;
  bool valueElectronic = false;
  bool valueWooden = false;
  bool valueConstruction = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Capture Image from Camera"),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Column(children: [
                Container(
                    height: 600,
                    width: 350,
                    child: controller == null
                        ? Center(child: Text("Loading Camera..."))
                        : !controller!.value.isInitialized
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : CameraPreview(controller!)),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton.icon(
                    //image capture button
                    onPressed: () async {
                      frames();
                      // try {
                      //   if (controller != null) {
                      //     //check if contrller is not null
                      //     if (controller!.value.isInitialized) {
                      //       //check if controller is initialized
                      //       image =
                      //           await controller!.takePicture(); //capture image
                      //       setState(() {
                      //         //update UI
                      //       });
                      //     }
                      //   }
                      // } catch (e) {
                      //   print(e); //show error
                      // }
                    },
                    icon: Icon(Icons.camera),
                    label: Text("Capture")),
                Container(
                  //show captured image
                  padding: EdgeInsets.all(30),
                  child: image == null
                      ? Text("No image captured")
                      : Image.file(
                          File(image!.path),
                          height: 500,
                          width: 300,
                        ),
                  //display captured image
                ),
                SizedBox(
                  height: 10,
                ),
                Text("What waste do you see?"),
                SizedBox(
                  height: 10,
                ),
                CheckboxListTile(
                  secondary: const Icon(Icons.add_box),
                  title: const Text('Paper'),
                  subtitle: Text('Books, Cartons, etc'),
                  value: valuePaper,
                  onChanged: (bool? value) {
                    setState(() {
                      valuePaper = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  secondary: const Icon(Icons.add_box),
                  title: const Text('Metal'),
                  subtitle: Text('Accidental car, plumbing material, etc'),
                  value: valueMetal,
                  onChanged: (bool? value) {
                    setState(() {
                      valueMetal = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  secondary: const Icon(Icons.add_box),
                  title: const Text('Wooden'),
                  subtitle: Text('Furniture, Plywood, etc'),
                  value: valueWooden,
                  onChanged: (bool? value) {
                    setState(() {
                      valueWooden = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  secondary: const Icon(Icons.add_box),
                  title: const Text('Electronic'),
                  subtitle: Text('Batteries, boards, etc'),
                  value: valueElectronic,
                  onChanged: (bool? value) {
                    setState(() {
                      valueElectronic = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  secondary: const Icon(Icons.add_box),
                  title: const Text('Construction'),
                  subtitle: Text('Bricks, Concrete Blocks, etc'),
                  value: valueConstruction,
                  onChanged: (bool? value) {
                    setState(() {
                      valueConstruction = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(
                  //image capture button
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecurityHomePage())),

                  icon: Icon(Icons.check_box_sharp),
                  label: Text("Submit"),
                ),
                SizedBox(
                  height: 35,
                ),
              ])),
            ),
          ],
        ),
      ),
    );
  }
}

// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   const DisplayPictureScreen({super.key, required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Display the Picture')),
//       // The image is stored as a file on the device. Use the `Image.file`
//       // constructor with the given path to display the image.
//       body: Image.file(File(imagePath)),
//     );
//   }
// }
