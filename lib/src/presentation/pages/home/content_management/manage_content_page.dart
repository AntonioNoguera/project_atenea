import 'package:flutter/material.dart';

import 'package:proyect_atenea/src/presentation/pages/home/content_management/departments/academic_department_item_row.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';


class ManageContentPage extends StatelessWidget {

  const ManageContentPage({super.key}); 

  @override
  Widget build(BuildContext context) {

    return AteneaScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 30.0,
        ),
        child: Stack(
          children: [
            Column(
              children: [
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
                const SizedBox(height: 20),

                Text(
                  'Departamentos Académicos Disponibles',
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor,
                    size: FontSizes.h5,
                    weight: FontWeights.semibold
                  ),
                ),

                
                const SizedBox(height: 20),
                
                Expanded(
                  child: SingleChildScrollView( 
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Column(
                          children: List.generate(8, (index) {
                            return AcademicDepartmentItemRow();
                          }),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 45.0),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [ 
                  Row(
                    children: [
                      Expanded(
                        child: AteneaButton(
                          text: 'Volver',
                          backgroundColor: AppColors.secondaryColor,
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