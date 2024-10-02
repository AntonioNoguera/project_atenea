import 'package:flutter/material.dart'; 
 
import 'package:proyect_atenea/app/widgets/AteneaScaffold.dart';
  

import 'package:proyect_atenea/app/values/AppTheme.dart';  
  
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
                    weight: FontWeights.regular
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
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            elevation: 5.0,
                            color: AppColors.ateneaWhite,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Temas Selectos de Materia Genérica #${index + 1}',
                                    style: AppTextStyles.builder(
                                      color: AppColors.ateneaBlack,
                                      size: FontSizes.body1,
                                      weight: FontWeights.semibold
                                    ),

                                    
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, 
                                          children: [
                                            Text(
                                              'Autor',
                                              style: 
                                              AppTextStyles.builder(
                                                color: AppColors.primaryColor,
                                                size: FontSizes.body2,
                                              )
                                            ),

                                            Text(
                                              'Noguera Guzman',
                                              style: 
                                              AppTextStyles.builder(
                                                color: AppColors.primaryColor,
                                                size: FontSizes.body2,
                                              )
                                            ),
                                          ],
                                        )
                                      ) ,
                                      

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Autor',
                                              style: 
                                              AppTextStyles.builder(
                                                color: AppColors.primaryColor,
                                                size: FontSizes.body2,
                                              )
                                            ),

                                            Text(
                                              'Noguera Guzman',
                                              style: 
                                              AppTextStyles.builder(
                                                color: AppColors.primaryColor,
                                                size: FontSizes.body2,
                                              )
                                            ),
                                          ],
                                        ) 
                                      )
                                    ] 
                                  ), 
                                ],
                              )
                            ),
                          ),
                        ),
                      );
                    }
                  ))
                )
              )
            )
          ] 
        )
      ),
    );
  }
}