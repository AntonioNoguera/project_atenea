import 'package:flutter/material.dart';
import 'pages/HomeScreen.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      home: HomeScreen(), // Aquí se especifica la pantalla inicial
    );
  }
}