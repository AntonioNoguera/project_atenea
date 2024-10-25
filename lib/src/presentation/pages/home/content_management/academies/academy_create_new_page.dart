import 'package:flutter/material.dart';

import 'package:proyect_atenea/src/presentation/pages/home/content_management/departments/academic_department_item_row.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';


class AcademyCreateNewPage extends StatelessWidget {

  const AcademyCreateNewPage({super.key}); 

  @override
  Widget build(BuildContext context) {

    return AteneaScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30.0,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                
                const SizedBox(height: 10.0,),
                
                Text(
                  'Nueva Academia',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor,
                    size: FontSizes.h3,
                    weight: FontWeights.semibold,
                  ),
                ),
                
                const SizedBox(height: 45.0),

                //Toggle bottons are gonna be required


                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            'Ingresa el nombre de la nueva Academia', 
                            textAlign: TextAlign.center,
                            style: 
                              AppTextStyles.builder(
                                size: FontSizes.h4,
                                color: AppColors.primaryColor
                              ),
                            ),

                          const AteneaField(placeHolder: "Nuevo Nombre", inputNameText: "Nombres"),

                          const SizedBox(height: 20.0,),

                          const Text('Ingenieros con permisos')

                          ],
                        ),
                      )
                    ),
                  
                  )

                  , 
                  AteneaButton(
                    onPressed: (){
                      Navigator.pop(context);

                  },
                  text:  'Volver',
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}