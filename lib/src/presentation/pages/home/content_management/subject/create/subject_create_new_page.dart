import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/academy_contributor_row.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/add_contributor_dialog.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';

class SubjectCreateNewPage extends StatelessWidget {
  const SubjectCreateNewPage({super.key});

  void _handleToggle(BuildContext context, int index) {
    Provider.of<ActiveIndexNotifier>(context, listen: false).setActiveIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActiveIndexNotifier(),
      child: Consumer<ActiveIndexNotifier>(
        builder: (context, activeIndexNotifier, child) {
          return AteneaScaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [

                        const SizedBox(height: 10.0),
                        
                        Text(
                          'Nueva Asignatura',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.builder(
                            color: AppColors.primaryColor,
                            size: FontSizes.h3,
                            weight: FontWeights.semibold,
                          ),
                        ),

                        const SizedBox(height: 10.0),

                        Text(
                          'Plan de Estudios',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.builder(
                            color: AppColors.primaryColor,
                            size: FontSizes.h5,
                            weight: FontWeights.regular,
                          ),
                        ),
                        
                        ToggleButtonsWidget(
                          onToggle: (index) => _handleToggle(context, index),
                          toggleOptions: const ['401', '440'],
                        ),

                        const SizedBox(height: 15.0),
                        
                        Text(
                          'Ingresa el nombre de la nueva asignatura',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.builder(
                            size: FontSizes.h5,
                            weight: FontWeights.regular,
                            color: AppColors.primaryColor,
                          ),
                        ),

                        const SizedBox(height: 5.0),

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
                            hasBorder: true
                          ),

                          svgIcon:SvgButtonStyle(
                            svgPath: 'assets/svg/add_user.svg', 
                            svgDimentions: 25
                          ),

                          textStyle: AppTextStyles.builder(
                            color: AppColors.primaryColor,
                            size: FontSizes.h5,
                            weight: FontWeights.light,
                          ),

                          text: 'Añadir Contribuidor', 
                        ),

                        const SizedBox(height: 60.0),

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
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Cancelar',
                          ),
                          
                          const SizedBox(width: 10.0),

                          Expanded(
                            child: AteneaButtonV2(
                              btnStyles: const AteneaButtonStyles(
                                backgroundColor: AppColors.secondaryColor, 
                                textColor: AppColors.ateneaWhite,
                              ),

                              onPressed: () {
                                Navigator.pop(context);
                              },
                              text: 'Crear Asignatura',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}