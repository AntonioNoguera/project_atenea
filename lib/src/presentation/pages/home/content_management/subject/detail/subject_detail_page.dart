import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/manage_content/subject_modify_content_page.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/app_ui_helpers.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/subject_provider.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/detail/widget/theme_or_file_subject.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_circular_progress.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart'; 

class SubjectDetailPage extends StatelessWidget {
  final SubjectEntity subject;

  const SubjectDetailPage({super.key, required this.subject});

  void _handleToggle(BuildContext context, int index) {
    Provider.of<ActiveIndexNotifier>(context, listen: false).setActiveIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final subjectProvider = Provider.of<SubjectProvider>(context, listen: false);

    return ChangeNotifierProvider(
      create: (context) => ActiveIndexNotifier(),
      child: FutureBuilder<SubjectEntity?>(
        future: subjectProvider.getSubject(subject.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { 
            return const AteneaScaffold(
              body: Center(
                child: AteneaCircularProgress(),
              )
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar la materia'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Materia no encontrada'));
          }

          final subject = snapshot.data!;
          return Consumer<ActiveIndexNotifier>(
            builder: (context, activeIndexNotifier, child) {
              return AteneaScaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: 30.0,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                                  
                      Text(
                        'Materia Seleccionada',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.builder(
                          color: AppColors.primaryColor,
                          size: FontSizes.body2,
                          weight: FontWeights.regular,
                        ),
                      ),

                      Text(
                        subject.name,
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
                                      subject.lastModificationContributor,
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
                                      AppUiHelpers.formatDateStringToWords(subject.lastModificationDateTime),
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
                              _renderedContent(activeIndexNotifier.activeIndex, subject),
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
                              textColor: AppColors.ateneaWhite,
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
                                  AteneaPageAnimator(page: SubjectModifyContentPage(subject: subject)),
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
          );
        },
      ),
    );
  }

  Widget _renderedContent(int activeIndex, SubjectEntity subject) {
    final Map<int, Widget> renderedContent = {
      0: subject.subjectPlanData?.subjectThemes != null
          ? Column(
              children: [
                if (subject.subjectPlanData!.subjectThemes!.halfTerm != null)
                  ThemeOrFileSubject(
                    contentType: 'Temas Medio Termino',
                    hasSvg: false,
                    content: subject.subjectPlanData!.subjectThemes!.halfTerm!,
                  )
                else
                  const Text(
                    'No hay temas para Medio Termino',
                    textAlign: TextAlign.center,
                  ),
                if (subject.subjectPlanData!.subjectThemes!.ordinary != null)
                  ThemeOrFileSubject(
                    contentType: 'Temas Ordinario',
                    hasSvg: false,
                    content: subject.subjectPlanData!.subjectThemes!.ordinary!,
                  )
                else
                  const Text(
                    'No hay temas para Ordinario',
                    textAlign: TextAlign.center,
                  ),
              ],
            )
          : const Center(
              child: Text(
                'No hay temas disponibles',
                textAlign: TextAlign.center,
              ),
            ),
      1: subject.subjectPlanData?.subjectFiles != null
          ? Column(
              children: [
                if (subject.subjectPlanData!.subjectFiles!.halfTerm != null)
                  ThemeOrFileSubject(
                    contentType: 'Archivos Medio Termino',
                    hasSvg: true,
                    content: subject.subjectPlanData!.subjectFiles!.halfTerm!,
                  )
                else
                  const Text(
                    'No hay archivos para Medio Termino',
                    textAlign: TextAlign.center,
                  ),
                if (subject.subjectPlanData!.subjectFiles!.ordinary != null)
                  ThemeOrFileSubject(
                    contentType: 'Archivos Ordinario',
                    hasSvg: true,
                    content: subject.subjectPlanData!.subjectFiles!.ordinary!,
                  )
                else
                  const Text(
                    'No hay archivos para Ordinario',
                    textAlign: TextAlign.center,
                  ),
              ],
            )
          : const Center(
              child: Text(
                'No hay archivos disponibles',
                textAlign: TextAlign.center,
              ),
            ),
    };

    return renderedContent[activeIndex] ?? const Text('Unrenderable');
  }

}
