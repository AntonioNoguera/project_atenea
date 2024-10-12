//Page in charge of show all the user his habilities related to the data handle of the academy lvl2
//Page in charge of show all the user his habilities related to the data handle of the lvl 3

import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/presentation/pages/home/my_subects/widgets/home_subject.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';

class AcademyDetailPage extends StatefulWidget { 

  const AcademyDetailPage({super.key});

  @override
  _AcademyDetailPageState createState() => _AcademyDetailPageState();
}

class _AcademyDetailPageState extends State<AcademyDetailPage> {
  int activeIndex = 0; 
  bool isButtonCollapsed = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      checkStateToggle();
    });
  }

  void checkStateToggle({bool calledFromToggle = false}) {

    if (_scrollController.offset >= 50 &&  !isButtonCollapsed ) {
        setState(() {
          isButtonCollapsed = true;
        }); 
      } else if (_scrollController.offset <= 50 &&  ( isButtonCollapsed || calledFromToggle)) {
        setState(() {
          isButtonCollapsed = false;
        }); 
      }
  }

  final Map<int, Widget> _renderedContent = {
    0: Column( 
        children: List.generate(11, (index) {
            return const HomeSubject();
          }),
        ),

    1: Column( 
        children: List.generate(12, (index) {
            return const HomeSubject();
          }),
        ),
  };

  void _handleToggle(int index) {
  setState(() {
    activeIndex = index;
  });

  // Espera a que se complete el setState antes de ejecutar el callback
  WidgetsBinding.instance.addPostFrameCallback((_) {
    checkStateToggle(calledFromToggle: true);
  });
}

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
                  'Detalle de Academia',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor,
                    size: FontSizes.h3,
                    weight: FontWeights.semibold,
                  ),
                ),

                const SizedBox(height: 10),
                
                Text('Planes de estudio', style: AppTextStyles.builder(size: FontSizes.body2, weight: FontWeights.bold),),
                
                const SizedBox(height: 5),

                ToggleButtonsWidget(
                  onToggle: _handleToggle,
                  toggleOptions: const ['401','440'],
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        AteneaCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                            ],
                          ),
                        ), 

                        const SizedBox(height: 10.0,),

                        _renderedContent[activeIndex] ?? const Text('Unrenderable')

                      ],
                    ),
                  ),
                ), 

                const SizedBox(height: 10.0),
                
                 
              ],
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [ 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        curve: Curves.decelerate,
                        duration: const Duration(milliseconds: 230),
                        width: isButtonCollapsed ? 60.0 : 200.0,
                        child: AteneaButton(
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
                          text: isButtonCollapsed ? null : 'Crear Asignatura',
                          iconSize: 30.0,
                          svgIcon: 'assets/svg/add.svg',
                          svgTint: AppColors.primaryColor,
                          enabledBorder: true,
                          backgroundColor: AppColors.ateneaWhite,
                          textStyle: AppTextStyles.builder(color: AppColors.primaryColor, size: FontSizes.body1),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
        )
      ),
    );
  }
}