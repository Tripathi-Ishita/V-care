import 'package:flutter/material.dart';
import 'package:major_vcare/screen/firstscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(), // Set the SplashScreen as the initial screen
    );
  }
}
