import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/subjects/widgets/theme_or_file_subject.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart'; 
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

//DEMO DEMO DEMO DEMO DEMO

class DepartmentDetailPage extends StatefulWidget { 

  const DepartmentDetailPage({super.key});

  @override
  _DepartmentDetailPageState createState() => _DepartmentDetailPageState();
}

class _DepartmentDetailPageState extends State<DepartmentDetailPage> {
  int activeIndex = 0; 

  final Map<int, Widget> _renderedContent = {
    0: Column( 
        children: List.generate(2, (index) {
            return ThemeOrFileSubject(
              contentType: 'Academias',
              hasSvg: index == 1,
            );
          }),
        ),

    1: Column( 
        children: List.generate(1, (index) {
            return ThemeOrFileSubject(
              contentType: 'Departamentos',
              hasSvg: index == 1,
            );
          }),
        ),
  };

  void _handleToggle(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return AteneaScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 50.0,
        ),
        child: Column(
          children: [
            Text(
              'Nombre de la Materia Genérica',
              textAlign: TextAlign.center,
              style: AppTextStyles.builder(
                color: AppColors.primaryColor,
                size: FontSizes.h3,
                weight: FontWeights.semibold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    AteneaCard(
                      child:Column(
                        children: [
                          Text(
                            'Redactado por:',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.builder(
                              color: AppColors.ateneaBlack,
                              size: FontSizes.body1,
                              weight: FontWeights.semibold,
                            ),
                          ),
                          Text(
                            'Michael Antonio Noguera Guzmán',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.builder(
                              color: AppColors.grayColor,
                              size: FontSizes.body2,
                              weight: FontWeights.regular,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Última Actualización:',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.builder(
                              color: AppColors.ateneaBlack,
                              size: FontSizes.body1,
                              weight: FontWeights.semibold,
                            ),
                          ),
                          Text(
                            '23 Sep 2024 | 15:20',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.builder(
                              color: AppColors.grayColor,
                              size: FontSizes.body2,
                              weight: FontWeights.regular,
                            ),
                          ),
                        ]
                      )
                    ),

                    
                    const SizedBox(height: 10),

                    const SizedBox(height: 10),
                    
                    ToggleButtonsWidget(
                      onToggle: _handleToggle,
                      toggleOptions: ['A','s'],
                    ),

                    const SizedBox(height: 10),
                    
                    _renderedContent[activeIndex] ?? const Text('Unrenderable')
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10.0),
            
            Row(
              children: [
                AteneaButton(
                  text: 'Volver',
                  backgroundColor: AppColors.secondaryColor,
                  onPressed: () { 
                  },
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: AteneaButton(
                    text: 'Marcar',
                    onPressed: () { 
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}