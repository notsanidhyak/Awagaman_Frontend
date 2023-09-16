// // import 'dart:typed_data';
// // import 'dart:ui';

// // import 'package:camera/camera.dart';

// // import 'package:flutter/foundation.dart';
// // import 'package:google_ml_kit/google_ml_kit.dart';

// // class UtilsScanner {
// //   UtilsScanner._();
// //   static Future<CameraDescription> getCamera(
// //       CameraLensDirection cameraLensDirection) async {
// //     return await availableCameras().then((List<CameraDescription> cameras) =>
// //         cameras.firstWhere((CameraDescription cameraDescription) =>
// //             cameraDescription.lensDirection == cameraLensDirection));
// //   }

// //   static InputImageRotation rotationIntToImageRotation(int rotation) {
// //     switch (rotation) {
// //       case 0:
// //         return InputImageRotation.rotation0deg;
// //       case 90:
// //         return InputImageRotation.rotation90deg;
// //       case 180:
// //         return InputImageRotation.rotation180deg;
// //       default:
// //         assert(rotation == 270);
// //         return InputImageRotation.rotation270deg;
// //     }
// //   }

// //   static Uint8List concatenatePlanes(List<Plane> planes) {
// //     final WriteBuffer allBytes = WriteBuffer();
// //     for (Plane plane in planes) {
// //       allBytes.putUint8List(plane.bytes);
// //     }
// //     return allBytes.done().buffer.asUint8List();
// //   }

// //   static InputImageMetadata buildMetaData(
// //       CameraImage image, InputImageRotation rotation) {
// //     return InputImageMetadata(

// //         : image.format.raw,
// //         size: Size(image.width.toDouble(), image.height.toDouble()),
// //         rotation: rotation,
// //         planeData: image.planes
// //             .map((Plane plane) => FirebaseVisionImagePlaneMetadata(
// //                 bytesPerRow: plane.bytesPerRow,
// //                 height: plane.height,
// //                 width: plane.width))
// //             .toList(), bytesPerRow: null, format: null);
// //   }

// //   static Future<dynamic> detect(
// //       {required CameraImage image,
// //       required Future<dynamic> Function(InputImage image)
// //           detectInImage,
// //       required int imageRotation}) async {
// //     return detectInImage(FirebaseVisionImage.fromBytes(
// //         concatenatePlanes(image.planes),
// //         buildMetaData(image, rotationIntToImageRotation(imageRotation))));
// //   }
// // }
// import 'dart:typed_data';
// import 'dart:ui';

// import 'package:camera/camera.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class UtilsScanner {
//   UtilsScanner._();

//   static Future<CameraDescription> getCamera(
//       CameraLensDirection cameraLensDirection) async {
//     return await availableCameras().then((List<CameraDescription> cameras) =>
//         cameras.firstWhere((CameraDescription cameraDescription) =>
//             cameraDescription.lensDirection == cameraLensDirection));
//   }

//   static Orientation rotationIntToImageRotation(int rotation) {
//     switch (rotation) {
//       case 0:
//         return Orientation.values[0];
//       // return Orientation.rotation0;
//       case 90:
//         return Orientation.values[90];
//       // return ImageRotation.rotation90;
//       case 180:
//         return Orientation.values[180];
//       // return ImageRotation.rotation180;
//       default:
//         assert(rotation == 270);
//         return Orientation.values[270];
//     }
//   }

//   static Uint8List concatenatePlanes(List<Plane> planes) {
//     final WriteBuffer allBytes = WriteBuffer();
//     for (Plane plane in planes) {
//       allBytes.putUint8List(plane.bytes);
//     }
//     return allBytes.done().buffer.asUint8List();
//   }

//   static InputImageMetadata buildMetaData(
//     CameraImage image,
//     InputImageRotation rotation,
//   ) {
//     // final imageFormat = InputImageFormat.fromRawValue(image.format.raw);
//     // final planeData = image.planes.map((plane) => InputImageMetadata(
//     //       bytesPerRow: plane.bytesPerRow,
//     //       height: plane.height,
//     //       width: plane.width,
//     //     )).toList();
//     // final imageFormat = InputImageFormat.fromRawValue(image.format.raw);
//     final imageFormat = InputImageFormatValue.fromRawValue(image.format.raw);
//     return InputImageMetadata(
//       size: Size(image.width.toDouble(), image.height.toDouble()),
//       rotation: rotation,
//       // planeData: planeData,

//       bytesPerRow: 2, format: imageFormat!,
//     );
//   }

//   // static InputImageMetadata buildMetaData(
//   //     CameraImage image, InputImageRotation rotation) {
//   //   return InputImageMetadata(
//   //     // rawFormat: image.format.raw,
//   //     size: Size(image.width.toDouble(), image.height.toDouble()),
//   //     rotation: rotationIntToImageRotation(imageRotation) as InputImageRotation,
//   //     planeData: image.planes
//   //         .map((Plane plane) => InputImagePlaneMetadata(
//   //               bytesPerRow: plane.bytesPerRow,
//   //               height: plane.height,
//   //               width: plane.width,
//   //             ))
//   //         .toList(),
//   //          bytesPerRow:, format: null,
//   //   );
//   // }

//   static Future<dynamic> detect({
//     required CameraImage image,
//     required Future<dynamic> Function(InputImage image) detectInImage,
//     required int imageRotation,
//   }) async {
//     return detectInImage(InputImage.fromBytes(
//       bytes: concatenatePlanes(image.planes),
//       metadata: buildMetaData(image,
//           rotationIntToImageRotation(imageRotation) as InputImageRotation),
//     ));
//   }
// }
