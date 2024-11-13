import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/manage_content/academy_manage_content.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/create/subject_create_new_page.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/subject/home_item_row.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/scroll_controller_notifier.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/subject_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_folding_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';

class AcademyDetailPage extends StatefulWidget {
  final AcademyEntity academy;

  const AcademyDetailPage({super.key, required this.academy});

  @override
  _AcademyDetailPageState createState() => _AcademyDetailPageState();
}

class _AcademyDetailPageState extends State<AcademyDetailPage> {
  int _activeIndex = 0;

  void _handleToggle(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ActiveIndexNotifier()),
        ChangeNotifierProvider(create: (context) => ScrollControllerNotifier()),
        FutureProvider<List<SubjectEntity>>(
          create: (context) => Provider.of<SubjectProvider>(context, listen: false)
              .getSubjectsByAcademyID(widget.academy.id),
          initialData: [],
        ),
      ],
      child: Consumer3<ActiveIndexNotifier, ScrollControllerNotifier, List<SubjectEntity>>(
        builder: (context, activeIndexNotifier, scrollNotifier, subjects, child) {
          return AteneaScaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Stack(
                children: [
                  subjects.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                              child: Column(
                                children: [
                                  Text(
                                    widget.academy.name,
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
                                    onToggle: _handleToggle,
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
                                      _renderedContent(subjects),
                                      const SizedBox(height: 50.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                      child: Column(
                        children: [
                          AteneaFoldingButton(
                            data: 'Nueva Materia',
                            svgIcon: 'assets/svg/add.svg',
                            onPressedCallback: () {
                              Navigator.push(
                                context,
                                AteneaPageAnimator(page: const SubjectCreateNewPage()),
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
                                  textColor: AppColors.ateneaWhite,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: AteneaButtonV2(
                                  text: 'Modificar Academia',
                                  btnStyles: const AteneaButtonStyles(
                                    backgroundColor: AppColors.primaryColor,
                                    textColor: AppColors.ateneaWhite,
                                  ),
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

  Widget _renderedContent(List<SubjectEntity> subjects) {
    final filteredSubjects = subjects
        .where((subject) => subject.planName == (_activeIndex == 0 ? '401' : '440'))
        .toList();

    return Column(
      children: filteredSubjects.map((subject) => HomeItemRow(subject: subject)).toList(),
    );
  }
}
