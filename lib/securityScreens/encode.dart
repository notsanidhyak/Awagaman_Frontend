import 'dart:convert';
import 'dart:io';
import 'dart:async';
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
  // late final imgBytes;
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  late final imgXFile;
  File? _image;
  String textData = '';
  final apiUrl = 'https://awagaman.onrender.com/';
  final ImagePicker imagePicker = ImagePicker();
  getImageFromGallery() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.camera);
    // imgBytes = await imgXFile!.readAsBytes();
    setState(() {
      imgXFile;
      // imgBytes;
    });
  }
  // void initState() {
  //   loadCamera();
  //   super.initState();
  // }

  // loadCamera() async {
  //   cameras = await availableCameras();
  //   if (cameras != null) {
  //     controller = CameraController(cameras![0], ResolutionPreset.max);
  //     //cameras[0] = first camera, change to 1 to another camera

  //     controller!.initialize().then((_) {
  //       if (!mounted) {
  //         return;
  //       }
  //       setState(() {});
  //     });
  //   } else {
  //     print("NO any camera found");
  //   }
  // }

  // Uint8List encodeImageAsJpg(Uint8List imgData) {
  //   // Decode the image data
  //   final image = img.decodeImage(imgData);

  //   // Encode the image as a JPEG byte array
  //   final jpgData = img.encodeJpg(image!);

  //   return Uint8List.fromList(jpgData);
  // }

  // String bytesToHex(List<int> bytes) {
  //   final hexChars = List<String>.generate(bytes.length,
  //       (int index) => bytes[index].toRadixString(16).padLeft(2, '0'));
  //   return hexChars.join();
  // }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    // final files;
    if (_image == null || textData.isEmpty) {
      return;
    }

    final response = await http.post(
      Uri.parse(apiUrl + '/upload'), // Append '/upload' to your API endpoint
      headers: {'Content-Type': 'multipart/form-data'},
      body: {
        'text': textData,
      },
      files: [
        http.MultipartFile(
          'image',
          _image!.readAsBytes().asStream(),
          _image!.lengthSync(),
          filename: 'image.jpg',
          contentType:
              MediaType('image', 'jpeg'), // Adjust the MIME type as needed.
        ),
      ],
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
    } else {
      print('Error uploading image: ${response.statusCode}');
    }
  }
  // postFrameToApi() async {
  //   final apiUrl = Uri.parse('https://awagaman.onrender.com/encode_face');
  //   // final apiUrl = 'https://awagaman.onrender.com/encode_face';
  //   final textData = '202151149';
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   // final imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

  //   // File imageFile = File(imgXFile!.path);
  //   Uint8List imgBytes = await imgXFile!.readAsBytes();

  //   // final Uint8List hexBytes =
  //   //     Uint8List.fromList(hex.encode(imgBytes).codeUnits);
  //   // Uint8List hexBytes = Uint8List.fromList(HEX.encode(imgBytes).codeUnits);
  //   // final hexString = bytesToHex(imgBytes);
  //   // Uint8List hexString = hex.encode(imgBytes);
  //   // final Uint8List jpgBytes = encodeImageAsJpg(imgBytes);
  //   // final requestBody = {
  //   //   'data': textData,
  //   //   // 'data': base64Encode(imgBytes),
  //   //   //dat // Convert Uint8List to base64
  //   //   'file': base64Encode(imgBytes),
  //   // };

  //   // if (imageFile.existsSync()) {
  //   if (imgXFile != null) {
  //     // final imgBytes = Uint8List.fromList(bytes);
  //     // String imgBase64 = base64Encode(imgBytes);
  //     print(imgXFile!.path);
  //     // final response = await http.post(
  //     //   Uri.parse(apiUrl),
  //     //   headers: {
  //     //     'Content-Type': 'application/json',
  //     //   },
  //     //   body: json.encode(requestBody),
  //     // );
  //     final request = http.MultipartRequest('POST', apiUrl);
  //     files:
  //     [
  //       http.MultipartFile(
  //         'image',
  //         imgXFile!.readAsBytes().asStream(),
  //         imgXFile!.lengthSync(),
  //         filename: 'image.jpg',
  //         contentType:
  //             MediaType('image', 'jpeg'), // Adjust the MIME type as needed.
  //       ),
  //     ];
  //     request.fields['text'] = textData;
  //     print(base64Encode(imgBytes));
  //     request.files.add(
  //       http.MultipartFile(
  //         'image',
  //         http.ByteStream.fromBytes(imgBytes),
  //         imgBytes.length,
  //         filename: 'image.jpg',
  //         contentType:
  //             MediaType('image', 'jpeg'), // Adjust the MIME type as needed.
  //       ),
  //     );

  //     // request.files.add( http.MultipartFile(
  //     //   //   // imgXFile
  //     //   'image',
  //     //   // imgXFile!.path,
  //     //   imgBytes,
  //     //   // imgBytes.length,
  //     //   filename: 'image.jpg',
  //     //   contentType: MediaType('image', 'jpeg'),
  //     // ));
  //     // request.fields['image'] = imgBytes;
  //     print(imgBytes);
  //     // print(hexString);
  //     // Send the request and get the response
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       var responseData = await response.stream.bytesToString();
  //       print('Response: $responseData');
  //     } else {
  //       print("Error sending frame. Status code: ${response.statusCode}");
  //     }
  //     // Now you can proceed with using imgBytes and imgBase64
  //   } else {
  //     print('No image picked.');
  //   }
  //   // } else {
  //   //   print("No image file");
  //   // }
  //   // final bytes = await rootBundle.load(image!.path); // Adjust the image path
  //   // final picker = ImagePicker();
  //   // final pickedFile = await picker.pickImage(source: ImageSource.camera);
  //   // final bytes = await pickedFile!.readAsBytes();
  //   // Uint8List imgBytes = Uint8List.fromList(bytes);
  //   // String imgBase64 = base64Encode(imgBytes);
  //   // final picker = ImagePicker();
  //   // final pickedFile = await picker.pickImage(source: ImageSource.camera);

  //   // Uint8List imgBytes = bytes.buffer.asUint8List();
  //   // String imgBase64 = base64Encode(imgBytes);
  // }

  // bool valueMetal = false;
  // bool valuePaper = false;
  // bool valueElectronic = false;
  // bool valueWooden = false;
  // bool valueConstruction = false;
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
            GestureDetector(
              onTap: () {
                getImageFromGallery();
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: imgXFile == null
                    ? null
                    : FileImage(File(
                        imgXFile!.path,
                      )),
                radius: MediaQuery.of(context).size.width * 0.20,
                child: imgXFile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        color: Colors.grey,
                        size: MediaQuery.of(context).size.width * 0.20,
                      )
                    : null,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  postFrameToApi();
                },
                child: Text("Submit"))
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //       child: Column(children: [
            //     Container(
            //         height: 600,
            //         width: 350,
            //         child: controller == null
            //             ? Center(child: Text("Loading Camera..."))
            //             : !controller!.value.isInitialized
            //                 ? Center(
            //                     child: CircularProgressIndicator(),
            //                   )
            //                 : CameraPreview(controller!)),
            //     SizedBox(
            //       height: 25,
            //     ),
            //     ElevatedButton.icon(
            //       //image capture button
            //       onPressed: () async {
            //         try {
            //           if (controller != null) {
            //             //check if contrller is not null
            //             if (controller!.value.isInitialized) {
            //               //check if controller is initialized
            //               imgXFile =
            //                   await controller!.takePicture(); //capture image
            //               setState(() {
            //                 //update UI
            //               });
            //             }
            //           }
            //         } catch (e) {
            //           print(e); //show error
            //         }
            //       },

            //       icon: Icon(Icons.camera),
            //       label: Text("Capture"),
            //     ),
            //     Container(
            //       //show captured image
            //       padding: EdgeInsets.all(30),
            //       child: imgXFile == null
            //           ? Text("No image captured")
            //           : Image.file(
            //               File(imgXFile!.path),
            //               height: 500,
            //               width: 300,
            //             ),
            //       //display captured image
            //     ),
            //     SizedBox(
            //       height: 10,
            //     ),
            //     Text("What waste do you see?"),
            //     SizedBox(
            //       height: 10,
            //     ),
            //     CheckboxListTile(
            //       secondary: const Icon(Icons.add_box),
            //       title: const Text('Paper'),
            //       subtitle: Text('Books, Cartons, etc'),
            //       value: valuePaper,
            //       onChanged: (bool? value) {
            //         setState(() {
            //           valuePaper = value!;
            //         });
            //       },
            //     ),
            //     CheckboxListTile(
            //       secondary: const Icon(Icons.add_box),
            //       title: const Text('Metal'),
            //       subtitle: Text('Accidental car, plumbing material, etc'),
            //       value: valueMetal,
            //       onChanged: (bool? value) {
            //         setState(() {
            //           valueMetal = value!;
            //         });
            //       },
            //     ),
            //     CheckboxListTile(
            //       secondary: const Icon(Icons.add_box),
            //       title: const Text('Wooden'),
            //       subtitle: Text('Furniture, Plywood, etc'),
            //       value: valueWooden,
            //       onChanged: (bool? value) {
            //         setState(() {
            //           valueWooden = value!;
            //         });
            //       },
            //     ),
            //     CheckboxListTile(
            //       secondary: const Icon(Icons.add_box),
            //       title: const Text('Electronic'),
            //       subtitle: Text('Batteries, boards, etc'),
            //       value: valueElectronic,
            //       onChanged: (bool? value) {
            //         setState(() {
            //           valueElectronic = value!;
            //         });
            //       },
            //     ),
            //     CheckboxListTile(
            //       secondary: const Icon(Icons.add_box),
            //       title: const Text('Construction'),
            //       subtitle: Text('Bricks, Concrete Blocks, etc'),
            //       value: valueConstruction,
            //       onChanged: (bool? value) {
            //         setState(() {
            //           valueConstruction = value!;
            //         });
            //       },
            //     ),
            //     SizedBox(
            //       height: 15,
            //     ),
            //     ElevatedButton.icon(
            //       //image capture button
            //       onPressed: () {
            //         postFrameToApi();
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => SecurityHomePage()));
            //       },

            //       icon: Icon(Icons.check_box_sharp),
            //       label: Text("Submit"),
            //     ),
            //     SizedBox(
            //       height: 35,
            //     ),
            //   ])),
            // ),
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
