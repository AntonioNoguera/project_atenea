import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/academy_contributor_row.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/add_contributor_dialog.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart'; 

class AcademicDepartmentManageContent extends StatelessWidget {
  final TextEditingController _departmentInputController = TextEditingController(text: 'Informática');

  AcademicDepartmentManageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child:  Stack(
            children: [
              Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
          child:
              Column(
                children: [

                  Text(
                    'Modificando Departamento',
                    style: AppTextStyles.builder(size: FontSizes.h3, weight: FontWeights.semibold),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20.0),

                  AteneaField(
                    placeHolder: 'Ingresa el nombre del departamento',
                    inputNameText: 'Nombre del Departamento',
                    controller: _departmentInputController,
                  ),

                  const SizedBox(height: 20.0),
                  
                  Text(
                    'Ingenieros con permisos',
                    style: AppTextStyles.builder(
                      size: FontSizes.h5,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(8, (index) {
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
                  AteneaButtonV2(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AddContributorDialog();
                        },
                      );
                    },
                    btnStyles: const AteneaButtonStyles(
                      backgroundColor: AppColors.ateneaWhite,
                      textColor: AppColors.primaryColor,
                      hasBorder: true,
                    ),
                    textStyle: AppTextStyles.builder(
                      color: AppColors.primaryColor,
                      size: FontSizes.h5,
                      weight: FontWeights.light,
                    ),
                    text: 'Añadir Contribuidor',
                    svgIcon: SvgButtonStyle(
                      svgPath: 'assets/svg/add_user.svg',
                      svgDimentions: 25,
                    ),
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AteneaButtonV2(
                            text: 'Cancelar',
                            btnStyles: const AteneaButtonStyles(
                              backgroundColor: AppColors.secondaryColor,
                              textColor: AppColors.ateneaWhite,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: AteneaButtonV2(
                              text: 'Guardar',
                              btnStyles: const AteneaButtonStyles(
                                backgroundColor: AppColors.primaryColor,
                                textColor: AppColors.ateneaWhite,
                              ),
                              onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AteneaDialog(
                  title: 'Modificando Departamento',
                  content: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 600,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Ajusta la altura automáticamente
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Se almacenarán los cambios realizados en el departamento ',
                                style: AppTextStyles.builder(
                                  color: AppColors.textColor,
                                  size: FontSizes.body2,
                                  weight: FontWeights.semibold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Nombre de la Academia:  ',
                                style: AppTextStyles.builder(
                                  color: AppColors.textColor,
                                  size: FontSizes.body2,
                                ),
                              ),
                              TextSpan(
                                text: 'Mecánica',
                                style: AppTextStyles.builder(
                                  color: AppColors.primaryColor,
                                  size: FontSizes.body2,
                                  weight: FontWeights.semibold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Contribuidores Registrados:  ',
                                style: AppTextStyles.builder(
                                  color: AppColors.textColor,
                                  size: FontSizes.body2,
                                ),
                              ),
                              TextSpan(
                                text: 'Michael Noguera, Fernando Paredes, Juan Perez',
                                style: AppTextStyles.builder(
                                  color: AppColors.primaryColor,
                                  size: FontSizes.body2,
                                  weight: FontWeights.semibold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Podrás realizar modificaciones de este contenido',
                                style: AppTextStyles.builder(
                                  color: AppColors.textColor,
                                  size: FontSizes.body2,
                                  weight: FontWeights.semibold,
                                ),
                              ),
                              TextSpan(
                                text: ' cualquier momento',
                                style: AppTextStyles.builder(
                                  color: AppColors.primaryColor,
                                  size: FontSizes.body2,
                                  weight: FontWeights.semibold,
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
                      textButton: 'Cancelar',
                      onPressedCallback: () {
                        Navigator.of(context).pop();
                      },
                      buttonStyles: const AteneaButtonStyles(
                        backgroundColor: AppColors.secondaryColor,
                        textColor: AppColors.ateneaWhite,
                      ),
                    ),
                    AteneaButtonCallback(
                      textButton: 'Aceptar',
                      onPressedCallback: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ); 
  }
}