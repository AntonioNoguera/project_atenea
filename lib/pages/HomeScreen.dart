import 'package:flutter/material.dart'; 

import '../common/widgets/AteneaField.dart';
import '../common/widgets/AteneaScaffold.dart';

import '../common/widgets/AteneaBackground.dart';
import '../core/utils/AppTheme.dart';

import '../common/widgets/AtenaDropDown.dart';

import '../common/widgets/AteneaDialog.dart';
import '../common/widgets/AteneaButton.dart';

import '../common/widgets/AteneaSquaredButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 


  @override
  Widget build(BuildContext context) {    

    String? selectedValue;
    final List<String> options = ['Opción 1', ];
    return AteneaScaffold(
      body: AteneaBackground( 
        child: SafeArea(  

          child : Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column( 
              children: [ 
                /*
                Text("Titulos", style: AppTextStyles.builder(color: AppColors.primaryColor, size: FontSizes.h1, weight: FontWeights.bold)),
                Text("Subtitulos", style: AppTextStyles.builder(color: AppColors.secondaryColor, size: FontSizes.h3)),
                Text("Contenidos", style: AppTextStyles.builder(color: AppColors.ateneaBlack, size: FontSizes.body1)), 

                const AteneaField(
                  placeHolder: "Ejemplo: Fernando",   
                  inputNameText:  "Ingresa el Usuario"
                ),

                AtenaDropDown(
                  hint : "Ingresa una opss",
                  items: options,
                  initialValue: selectedValue,
                  onChanged: (value) {
                    print(value);
                  },
                ),

                AteneaButton(
                  text: "Presioname",
                  svgIcon: 'assets/svg/Historial.svg',
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
                  }
                )
                ,
                
                Card(
                  elevation: 10, // Sombras
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Bordes redondeados
                  ),
                  child:  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Titulos Titulos Titulos TitulosTitulosTitulos ',
                          style: AppTextStyles.builder(color : AppColors.ateneaBlack, size : FontSizes.h4, weight: FontWeights.semibold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Contenido Contenido  ',
                          style: AppTextStyles.builder(color : AppColors.ateneaBlack, size : FontSizes.body1, weight: FontWeights.regular),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                */
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) =>  Ateneasquaredbutton(text: "text", svgIcon: 'assets/svg/Historial.svg', onPressed: (){ print("sda"); }),
                    itemCount: 4,
                  ),
                ),
                   
                                    
              ]
            ),
          )
        )  
      ),
    );
  }
}