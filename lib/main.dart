import 'package:avagaman/authScreens/home.dart';
import 'package:camera/camera.dart';
// import 'package:avagaman/authScreens/intro.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const Avagaman());
}

class Avagaman extends StatelessWidget {
  const Avagaman({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
