// // import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

// class FaceDetectionPage extends StatefulWidget {
//   const FaceDetectionPage({super.key});

//   @override
//   State<FaceDetectionPage> createState() => _FaceDetectionPageState();
// }

// class _FaceDetectionPageState extends State<FaceDetectionPage> {
//   final FaceDetector _faceDetector = FaceDetector(
//     options: FaceDetectorOptions(
//       enableContours: true,
//       enableClassification: true,
//     ),
//   );
//   bool _canProcess = true;
//   bool _isBusy = false;
//   CustomPaint? _customPaint;
//   String? text;
//   @override
//   void dispose() {
//     _canProcess = false;
//     _faceDetector.close();
//     // TODO: implement dispose
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
