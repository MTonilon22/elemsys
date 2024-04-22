import 'package:elemsys/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:elemsys/homepage.dart'; // Importing the HomePage file
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Using the HomePage widget as the home page
    );
  }
}
