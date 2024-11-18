import 'package:flutter/material.dart';

import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/add_contributor_dialog.dart';
 
import 'package:proyect_atenea/src/presentation/values/app_theme.dart'; 
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
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
                          return const Padding(
                            padding:   EdgeInsets.symmetric(vertical: 5.0),
                             
                            child: Text('TODO'),/*AcademyContributorRow(
                              index: index,
                              content: 'Item $index',
                              onClose: () => {
                                print(index)
                              },
                            ),
                            */
                          );
                        }), 
                      ),
                    ), 
                  ),

                  AteneaButtonV2(
                    onPressed: () { 
                      /*
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AddContributorDialog();
                        }
                      );
                      */
                    }, 
                    
                    btnStyles: const AteneaButtonStyles(
                      backgroundColor: AppColors.ateneaWhite, 
                      textColor: AppColors.primaryColor, 
                      hasBorder: true,
                    ),

                    textStyle: AppTextStyles.builder(
                      color: AppColors.primaryColor,
                      size: FontSizes.h5,
                      weight: FontWeights.light
                    ), 

                    text: 'Añadir Contribuidor',

                    svgIcon : SvgButtonStyle(
                      svgPath: 'assets/svg/add_user.svg',
                     svgDimentions: 25
                    ), 

                  ),

                  const SizedBox(height: 60.0,)
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
                      AteneaButtonV2(
                        btnStyles: const AteneaButtonStyles(
                            backgroundColor: AppColors.secondaryColor,
                            textColor: AppColors.ateneaWhite
                          ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: 'Cancelar',
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: AteneaButtonV2( 
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AteneaDialog(
                                  title: 'Nueva Academia',
                                  content: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 600,
                                      maxHeight: 190,
                                    ),
                                    child: Column(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '¡Estás a punto de crear una nueva academia! ',
                                                  style: AppTextStyles.builder(
                                                    color: AppColors.textColor,
                                                    size: FontSizes.body2,
                                                    weight: FontWeights.semibold
                                                  ),
                                                ), 
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 15.0,), 
                                          Text(
                                            'Nombre de la Academia:  ',
                                            style: AppTextStyles.builder(
                                              color: AppColors.textColor,
                                              size: FontSizes.body2,
                                            ),
                                          ),
                                          Text(
                                            'Mecánica',
                                            style:AppTextStyles.builder(
                                              color: AppColors.primaryColor,
                                              size: FontSizes.body2,
                                              weight: FontWeights.semibold
                                            ),
                                          ),
  
                                          const SizedBox(height: 15.0,),
                                          
                                          Text(
                                            'Contribuidores Registrados:  ',
                                            style: AppTextStyles.builder(
                                              color: AppColors.textColor,
                                              size: FontSizes.body2,
                                            ),
                                          ),

                                          Text(
                                            'Michael Noguera, Fernando Paredes, Juan Perez',
                                            style:AppTextStyles.builder(
                                              color: AppColors.primaryColor,
                                              size: FontSizes.body2,
                                              weight: FontWeights.semibold
                                            ),
                                          ),  

                                          const SizedBox(height: 15.0,),
                                          
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'No te preocupes, pués podrás añadir/eliminar/modificar contribuidores en',
                                                  style: AppTextStyles.builder(
                                                    color: AppColors.textColor,
                                                    size: FontSizes.body2,
                                                    weight: FontWeights.regular
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' cualquier momento.',
                                                  style:AppTextStyles.builder(
                                                    color: AppColors.primaryColor,
                                                    size: FontSizes.body2,
                                                    weight: FontWeights.semibold
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                            
                                        ],
                                      ),
                                    ),
                                    buttonCallbacks: [
                                    AteneaButtonCallback(
                                      textButton:'Cancelar',
                                      onPressedCallback: () {
                                        Navigator.of(context).pop();
                                      },
                                      buttonStyles: const AteneaButtonStyles(backgroundColor: AppColors.secondaryColor, textColor: AppColors.ateneaWhite)
                                    ),
                                    AteneaButtonCallback(
                                      textButton:'Aceptar',
                                      onPressedCallback: () {
                                        Navigator.of(context).pop();
                                      }
                                    ),
                                  ],
                                );
                              },
                            );
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