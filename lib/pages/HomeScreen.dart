import 'package:flutter/material.dart';
import '../core/utils/widgets/AteneaButton.dart';
import '../core/utils/AppTheme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Container(
          color: Colors.lightBlueAccent, // Establece el color de fondo aquí
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              
              AteneaButton(
                text: 'Iniciar',
                onPressed: () {
                  print('Botón presionado');
                },
                backgroundColor: const Color.fromARGB(255, 34, 136, 37),
                textColor: Colors.white,
                borderRadius: 10.0,
                textStyle: const TextStyle(
                  fontSize: FontSizes.h1,
                  color: Colors.white,
                ),
              ),
          
              ElevatedButton(
                onPressed: () {
                  print('Button pressed');
                },
                child: Text('Press me'),
              ),
            ],
          )
        )  ,
      ),
    );
  }
}