import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/subject_modify_content_page.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/detail/widget/theme_or_file_subject.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart'; 
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class SubjectDetailPage extends StatelessWidget {
  const SubjectDetailPage({super.key});

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
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: 30.0,
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
                          const SizedBox(height: 10),
                          ToggleButtonsWidget(
                            onToggle: (index) => _handleToggle(context, index),
                            toggleOptions: const ['Temas', 'Recursos'],
                          ),
                          const SizedBox(height: 10),
                          _renderedContent(activeIndexNotifier.activeIndex),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: AteneaButtonV2(
                          text: 'Modificar Contenido',
                          onPressed: () {
                            Navigator.push(
                              context,
                              AteneaPageAnimator(page: const SubjectModifyContentPage())
                            );
                          },
                        ),
                      ),
                    ],
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
          return ThemeOrFileSubject(
            contentType: 'Contenido del tema',
            hasSvg: false,
          );
        }),
      ),
      1: Column(
        children: List.generate(1, (index) {
          return ThemeOrFileSubject(
            contentType: 'Recursos',
            hasSvg: true,
          );
        }),
      ),
    };

    return renderedContent[activeIndex] ?? const Text('Unrenderable');
  }
}