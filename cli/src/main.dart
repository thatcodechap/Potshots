import 'package:cli/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'WelcomeScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}