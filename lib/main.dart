import 'package:flutter/material.dart';
import 'package:lesson/lesson1.dart';
import 'package:lesson/pages/weather_page.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
    //  MaterialApp(
  }
}

