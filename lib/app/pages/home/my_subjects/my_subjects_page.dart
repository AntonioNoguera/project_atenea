import 'package:flutter/material.dart'; 
 
import 'package:proyect_atenea/app/widgets/AteneaScaffold.dart';
  

import 'package:proyect_atenea/app/values/AppTheme.dart'; 

import 'package:proyect_atenea/app/widgets/atenea_dialog.dart';
  
import 'package:proyect_atenea/app/widgets/AteneaButton.dart';  

class MySubjectsPage extends StatelessWidget {
  const MySubjectsPage({super.key});
 
  @override
  Widget build(BuildContext context) {     

    return AteneaScaffold( 
      body : Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 50.0
          ),
        
        child: Column( 
          children: [
            Text(
              'Mis Materias',
              style: AppTextStyles.builder(
                    color: AppColors.primaryColor, 
                    size: FontSizes.h2, 
                    weight: FontWeights.semibold
                  )
            ),

            const SizedBox(height: 20.0,),
             AteneaButton(
              text : 'Añadir Nueva Materia',
              expandedText : true,
              svgIcon: 'assets/svg/edit_contents.svg',
              onPressed: () {
                print("Pressed");
              }
            ),

            Expanded( 
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric( 
                    vertical: 20.0,
                  ),
                  child: Column(
                    children: List.generate(30, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0), // Espacio entre Cards
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0), // Padding dentro del Card
                              child: Text('Este es el Card #${index + 1}'),
                            ),
                          ),
                        ),
                      );
                    }
                  )
                )
                )
              )
            )


          ] 
          
        )
      ),
    );
  }
}