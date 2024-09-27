import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 

import 'firebase_options.dart';

import 'fire_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Asegúrate de usar las opciones correctas
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      home: FirestoreExample(),
    );
  }
}
