import 'package:flutter/material.dart';

import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/academy_create/widgets/academy_contributor_row.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/add_contributor_dialog.dart';
 
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: 
              Column(
                children: [
                  const SizedBox(height: 10.0),

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

                  Text(
                    'Ingresa el nombre de la nueva academia',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.builder(
                      size: FontSizes.h5,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  
                  const SizedBox(height: 5.0,),
                  
                  const AteneaField(
                    placeHolder: 'Nuevo Nombre',
                    inputNameText: 'Nombres',
                  ),

                  const SizedBox(height: 20.0),

                  Text(
                    'Ingenieros con permisos',
                    style: AppTextStyles.builder(
                      size: FontSizes.h5,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: AcademyContributorRow(
                              index: index,
                              content: 'Item $index',
                              onClose: () => {
                                print(index)
                              },
                            ),
                          );
                        }), 
                      ),
                    ), 
                  ),

                  AteneaButton(
                    onPressed: () { 
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AddContributorDialog();
                        }
                      );
                    }, 

                    enabledBorder: true,

                    backgroundColor: AppColors.ateneaWhite,

                    iconSize: 25,

                    textStyle: AppTextStyles.builder(
                      color: AppColors.primaryColor,
                      size: FontSizes.h5,
                      weight: FontWeights.light
                    ),

                    svgTint: AppColors.primaryColor,

                    text: 'Añadir Contribuidor',
                    svgIcon : 'assets/svg/add_user.svg',

                  ),

                  SizedBox(height: 60.0,)
                ],
              ),

            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      AteneaButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: 'Cancelar',
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: AteneaButton(
                          backgroundColor: AppColors.secondaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: 'Crear Academia',
                        ),
                      ),
                    ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}