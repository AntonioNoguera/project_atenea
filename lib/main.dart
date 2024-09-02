import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/HomeScreen.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(98, 217, 178, 175), // color de la barra de estado
          statusBarIconBrightness: Brightness.dark, // brillo de los íconos
        ),
        child: HomeScreen(),
      ),
    );
  }
}
