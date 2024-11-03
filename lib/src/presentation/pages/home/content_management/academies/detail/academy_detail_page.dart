import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/manage_content/academy_manage_content.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/create/subject_create_new_page.dart';
import 'package:proyect_atenea/src/presentation/pages/home/my_subects/widgets/home_subject.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/scroll_controller_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_folding_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';

class AcademyDetailPage extends StatelessWidget {
  const AcademyDetailPage({super.key});

  void _handleToggle(BuildContext context, int index) {
    
    Provider.of<ActiveIndexNotifier>(context, listen: false).setActiveIndex(index);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ScrollControllerNotifier>(context, listen: false).setButtonCollapsed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ActiveIndexNotifier()),
        ChangeNotifierProvider(create: (context) => ScrollControllerNotifier()),
      ],
      child: Consumer2<ActiveIndexNotifier, ScrollControllerNotifier>(
        builder: (context, activeIndexNotifier, scrollNotifier, child) {
          return AteneaScaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05,),
                        child: Column(
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
                            Text(
                              'Planes de estudio',
                              style: AppTextStyles.builder(
                                size: FontSizes.body2,
                                weight: FontWeights.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ToggleButtonsWidget(
                              onToggle: (index) => _handleToggle(context, index),
                              toggleOptions: const ['401', '440'],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollNotifier.scrollController,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.05,
                            ),
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
                                const SizedBox(height: 10.0),
                                _renderedContent(activeIndexNotifier.activeIndex),

                                const SizedBox(height:  50.0),
                              ],
                            ),
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
                    child:
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * 0.05,),
                      child :
                      Column(
                        children: [
                              AteneaFoldingButton(
                              data: 'Nueva Materia ',
                              svgIcon: 'assets/svg/add.svg',
                              onPressedCallback: () {
                                  Navigator.push(
                                      context,
                                      AteneaPageAnimator(page: SubjectCreateNewPage()),
                                    );
                                },
                            ),  
                          
                          const SizedBox(height: 10),
                          Row(
                            children: [
                                
                              AteneaButtonV2(
                                text: 'Volver',
                                btnStyles: const AteneaButtonStyles(
                                  backgroundColor: AppColors.secondaryColor,
                                 textColor: AppColors.ateneaWhite
                                 ), 
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),

                              const SizedBox(width: 10,),
                              

                              Expanded(
                                child: AteneaButtonV2(
                                  text: 'Modificar Academia',
                                  btnStyles: const AteneaButtonStyles(
                                    backgroundColor: AppColors.primaryColor, 
                                    textColor: AppColors.ateneaWhite
                                  )  ,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      AteneaPageAnimator(page: AcademyManageContent()),
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
        },
      ),
    );
  }

  Widget _renderedContent(int activeIndex) {
    final Map<int, Widget> renderedContent = {
      0: Column(
        children: List.generate(2, (index) {
          return const HomeSubject();
        }),
      ),
      1: Column(
        children: List.generate(12, (index) {
          return const HomeSubject();
        }),
      ),
    };

    return renderedContent[activeIndex] ?? const Text('Unrenderable');
  }
}