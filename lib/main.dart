import 'package:flutter/material.dart';
import 'pages/HomeScreen.dart'; // Importa la pantalla que creaste

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Aquí se especifica la pantalla inicial
    );
  }
}