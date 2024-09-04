import 'package:flutter/material.dart'; 

import '../common/widgets/AteneaField.dart';
import '../common/widgets/AteneaScaffold.dart';

import '../common/widgets/AteneaBackground.dart';
import '../core/utils/AppTheme.dart';

import '../common/widgets/AtenaDropDown.dart';

import '../common/widgets/AteneaDialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 


  @override
  Widget build(BuildContext context) {    

    String? selectedValue;
    final List<String> options = ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 3', 'Opción 3', 'Opción 3', 'Opción 3', 'Opción 3', 'Opción 3'];

    return AteneaScaffold(
      body: AteneaBackground(
        child: Center(
          child: SafeArea(
            minimum: EdgeInsets.all(MediaQuery.of(context).size.width*.15),
            child: Column( 
              children: [ 
                Text("Titulos", style: AppTextStyles.builder(color: AppColors.primaryColor, size: FontSizes.h1, weight: FontWeights.bold)),
                Text("Subtitulos", style: AppTextStyles.builder(color: AppColors.secondaryColor, size: FontSizes.h3)),
                Text("Contenidos", style: AppTextStyles.builder(color: AppColors.ateneaBlack, size: FontSizes.body1)), 

                const AteneaField(
                  placeHolder: "Ejemplo: Fernando",   
                  inputNameText:  "Ingresa el Usuario"
                ),
                Padding(
                padding: const EdgeInsets.only(top: 8.0), // Espacio inferior de 8 píxeles
                child: AtenaDropDown(
                  hint : "Ingresa una opss",
                  items: options,
                  initialValue: selectedValue,
                  onChanged: (value) {
                    print(value);
                  },
                ), 
              ),

              ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return  (
                    AteneaDialog(
                      parentContext: context,
                      childContent: const Column(
                        children: [
                          Text("asdfasdf"),
                          Text("asdfasdf"),
                          Text("asdfasdf"),
                          Text("asdfasdf"),
                          Text("asdfasdf"),
                        ]
                      )
                    )
                  );
                },
              );
            },
            child: Text('Mostrar Bottom Sheet'),
          ),
                  
              ]
            )
          )  
        ),
      ),
    );
  }
}