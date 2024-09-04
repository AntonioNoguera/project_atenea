import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/HomeScreen.dart';
import 'core/utils/AppTheme.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor.withOpacity(0.65), // color de la barra de estado
          statusBarIconBrightness: Brightness.dark, // brillo de los íconos
        ),
        child: HomeScreen(),
      ),
    );
  }
}
