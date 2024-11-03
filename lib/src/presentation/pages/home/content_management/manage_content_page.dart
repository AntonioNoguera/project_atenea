import 'package:flutter/material.dart';

import 'package:proyect_atenea/src/presentation/pages/home/content_management/departments/detail/widgets/academic_department_item_row.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';


class ManageContentPage extends StatelessWidget {

  const ManageContentPage({super.key}); 

  @override
  Widget build(BuildContext context) {

    return AteneaScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 30.0,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                
                const SizedBox(height: 10.0,),
                
                Text(
                  'Administrar Contenidos',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor,
                    size: FontSizes.h3,
                    weight: FontWeights.semibold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  'Posees un super usuario, te permitirá editar tanto academias, como departamentos académicos, prueba entrando a un departamento académico,',
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor,
                    size: FontSizes.body2,
                    weight: FontWeights.regular,
                  ),
                ),
                const SizedBox(height: 15),

                Text(
                  textAlign: TextAlign.center,
                  'Departamentos Académicos Disponibles',
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor.withOpacity(.8),
                    size: FontSizes.h5,
                    weight: FontWeights.semibold
                  ),
                ),

                const SizedBox(height: 10),
                
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * 0.05), // Define el padding horizontal

                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Column(
                            children: List.generate(8, (index) {
                              return AcademicDepartmentItemRow();
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 45.0),
              ],
            ),
            Positioned(
              bottom: 0,
              left:  MediaQuery.of(context).size.width * 0.05,
              right:  MediaQuery.of(context).size.width * 0.05,
              child: Column(
                children: [ 
                  Row(
                    children: [
                      Expanded(
                        child: AteneaButtonV2(
                          text: 'Volver',
                          btnStyles: const AteneaButtonStyles(
                            backgroundColor: AppColors.secondaryColor,
                            textColor: AppColors.ateneaWhite,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}