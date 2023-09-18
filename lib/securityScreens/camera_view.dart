// import 'dart:io';
// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:avagaman/securityScreens/home.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Report extends StatefulWidget {
//   const Report({
//     super.key,
//   });

//   @override
//   State<Report> createState() => _ReportState();
// }

// class _ReportState extends State<Report> {
//   List<CameraDescription>? cameras; //list out the camera available
//   CameraController? controller; //controller for camera
//   XFile? image;

//   void initState() {
//     loadCamera();
//     super.initState();
//   }

//   loadCamera() async {
//     // late List<int> frameBytes;
//     cameras = await availableCameras();
//     if (cameras != null) {
//       controller = CameraController(cameras![0], ResolutionPreset.medium);
//       //     final Size size = await controller.getRecommendedPreviewSize(Size(1920, 1080));
//       // await controller.setResolutionPreset(size: Size(size.width, size.width), resolutionPreset: ResolutionPreset.medium);

//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       });
//     } else {
//       print("NO any camera found");
//     }
//   }

//   frames() async {
//     await controller!.startImageStream((CameraImage image) async {
//       List<int> frameBytes;
//       printImageDimensions(image);
//       frameBytes = await convertCameraImageToBytes(image);
//       postByteStreamToApi(frameBytes, "202151149");
//     });
//     // Future.delayed(Duration(seconds: 5));
//     // controller!.stopImageStream();
//     // return frameBytes;
//   }

//   void printImageDimensions(CameraImage image) {
//     final Plane plane = image.planes[0];
//     final int? width = plane.width;
//     final int? height = plane.height;
//     print('Image Dimensions: $width x $height');
//   }

//   List<int> convertCameraImageToBytes(CameraImage image) {
//     final Plane plane = image.planes[0];
//     final bytes = Uint8List.fromList(plane.bytes);
//     return bytes;
//   }

//   void postByteStreamToApi(List<int> byteStream, String textData) async {
//     var apiUrl = Uri.parse('https://awagaman.onrender.com/detect_faces');
//     try {
//       // var request = http.MultipartRequest('POST', apiUrl);

//       // var headers = {"Content-Type": "image/jpeg"};
//       // var imageFile = http.MultipartFile.fromBytes(
//       //   'image',
//       //   byteStream,
//       //   filename: 'image.jpg', // Adjust the filename and MIME type as needed
//       //   // contentType: ,
//       // );
//       // request.headers.addAll(headers);
//       // request.files.add(imageFile);
//       // var response = await request.send();
//       //  String base64Encoded = base64Encode(byteStream);

//       // Create the HTTP request
//       var response = await http.post(
//         apiUrl,
//         // data={
//         //   'text'='202151149'
//         // },

//         // files:byteStream,
//         headers: {
//           'Content-Type':
//               'application/octet-stream', // Set the content type to octet-stream
//         },
//         body: base64Encode(
//             byteStream), // Send the base64-encoded byte stream as the request body
//       );

//       if (response.statusCode == 200) {
//         // Request was successful
//         print('Successfully uploaded byte stream to the API.');
//       } else {
//         // Request failed
//         print(
//             'Failed to upload byte stream to the API. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle any exceptions that occur during the HTTP request
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Capture Image from Camera"),
//         backgroundColor: Colors.blue,
//       ),
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                   child: Column(children: [
//                 Container(
//                     height: 400,
//                     width: 400,
//                     child: controller == null
//                         ? const Center(child: Text("Loading Camera..."))
//                         : !controller!.value.isInitialized
//                             ? const Center(
//                                 child: CircularProgressIndicator(),
//                               )
//                             : CameraPreview(controller!)),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 ElevatedButton.icon(
//                     //image capture button
//                     onPressed: () async {
//                       frames();
//                     },
//                     icon: Icon(Icons.camera),
//                     label: Text("Capture")),
//                 Container(
//                   //show captured image
//                   padding: EdgeInsets.all(30),
//                   child: image == null
//                       ? Text("No image captured")
//                       : Image.file(
//                           File(image!.path),
//                           height: 680,
//                           width: 300,
//                         ),
//                   //display captured image
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ElevatedButton.icon(
//                   //image capture button
//                   onPressed: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const SecurityHomePage())),

//                   icon: Icon(Icons.check_box_sharp),
//                   label: Text("Submit"),
//                 ),
//                 SizedBox(
//                   height: 35,
//                 ),
//               ])),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart';

class Report extends StatefulWidget {
  const Report({
    super.key,
  });

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<CameraDescription>? cameras; //list out the cameras available
  CameraController? controller; //controller for the camera
  XFile? image;

  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.medium);
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("No camera found");
    }
  }

  Future<void> captureAndSendSquareImage() async {
    if (!controller!.value.isInitialized) {
      return;
    }

    try {
      final XFile capturedImage = await controller!.takePicture();
      final File imageFile = File(capturedImage.path);

      // Resize the image to make it square
      final imageBytes =
          await resizeImageToSpecificDimensions(imageFile, 180, 180);

      // Send the square image to the API
      await sendImageToApi(imageBytes);
    } catch (e) {
      print("Error capturing and sending image: $e");
    }
  }

  Future<Uint8List> resizeImageToSpecificDimensions(
      File imageFile, int width, int height) async {
    final bytes = await imageFile.readAsBytes();
    final img = decodeImage(Uint8List.fromList(bytes));

    // Resize the image to specific dimensions
    final resizedImg = copyResize(img!, width: width, height: height);

    return Uint8List.fromList(
        encodeJpg(resizedImg)); // Use encodeJpg for JPEG format
  }
  // Future<Uint8List> resizeImageToSpecificDimensions(
  //     File imageFile, int width, int height) async {
  //   final bytes = await imageFile.readAsBytes();
  //   final img.Image imgData = img.decodeImage(Uint8List.fromList(bytes))!;

  //   // Resize the image to specific dimensions
  //   final resizedImg = img.copyResize(imgData, width: width, height: height);

  //   // Convert the image to JPEG format
  //   return Uint8List.fromList(img.encodeJpg(resizedImg));
  // }

  Future<void> sendImageToApi(List<int> imageBytes) async {
    final apiUrl = Uri.parse('https://awagaman.onrender.com/detect_faces');
    try {
      print("hello bandar");
      print(Uint8List.fromList(imageBytes));
      final response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'image/jpeg', // Set the content type to octet-stream
        },
        body: Uint8List.fromList(
            imageBytes), // Send the square image as the request body
      );

      if (response.statusCode == 200) {
        // Request was successful
        print('Successfully uploaded square image to the API.');
      } else {
        // Request failed
        print(
            'Failed to upload square image to the API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Capture and Send Square Image"),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      width: 400,
                      child: controller == null
                          ? const Center(child: Text("Loading Camera..."))
                          : !controller!.value.isInitialized
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CameraPreview(controller!),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await captureAndSendSquareImage();
                      },
                      icon: Icon(Icons.camera),
                      label: Text("Capture and Send"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text("Back"),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
