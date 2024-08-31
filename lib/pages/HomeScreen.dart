import 'package:flutter/material.dart';
import '../core/utils/widgets/AteneaButton.dart';
import '../core/utils/AppTheme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Container(
          color: Colors.white, // Establece el color de fondo aquí
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              Text(
                "Titulo de Contenido", 
                style: AppTextStyles.builder(
                  color:AppColors.ateneaBlack,
                  size: FontSizes.h1,
                  weight: FontWeights.bold
                )
              ),
              AteneaButton(
                text: 'Iniciar',
                onPressed: () {
                  print('Botón presionado');
                },
                backgroundColor: const Color.fromARGB(255, 34, 136, 37), 
                borderRadius: 10.0,
                textStyle: AppTextStyles.builder(
                  color: AppColors.ateneaWhite,
                  size: FontSizes.h3
                )
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