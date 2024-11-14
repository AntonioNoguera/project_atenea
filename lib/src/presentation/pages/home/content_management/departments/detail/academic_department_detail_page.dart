import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/academy_create_new_page.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/academy_item_row.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/departments/manage_content/academic_department_manage_content.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/academy_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/scroll_controller_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_folding_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class AcademicDepartmentDetailPage extends StatelessWidget {
  final DepartmentEntity department;

  const AcademicDepartmentDetailPage({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScrollControllerNotifier()),
        FutureProvider<List<AcademyEntity>>(
          create: (context) => Provider.of<AcademyProvider>(context, listen: false).getAcademiesByDepartmentId(department.id),
          initialData: [],
        ),
      ],
      child: Consumer2<ScrollControllerNotifier, List<AcademyEntity>>(
        builder: (context, scrollNotifier, academies, child) {
          return AteneaScaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        department.name,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.builder(
                          color: AppColors.primaryColor,
                          size: FontSizes.h3,
                          weight: FontWeights.semibold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Posees un super usuario, te permitirá editar tanto academias, como departamentos académicos, prueba entrando a un departamento académico.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.builder(
                          color: AppColors.primaryColor,
                          size: FontSizes.body2,
                          weight: FontWeights.regular,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Academías Disponibles',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.builder(
                          color: AppColors.primaryColor.withOpacity(.8),
                          size: FontSizes.h5,
                          weight: FontWeights.semibold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: academies.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                controller: scrollNotifier.scrollController,
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.05,
                                ),
                                itemCount: academies.length,
                                itemBuilder: (context, index) {
                                  final academy = academies[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: AcademyItemRow(academy: academy),
                                  );
                                },
                              ),
                      ),
                      const SizedBox(height: 45.0),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AteneaFoldingButton(
                                data: 'Nueva Academia',
                                svgIcon: 'assets/svg/add.svg',
                                onPressedCallback: () {
                                  Navigator.push(
                                    context,
                                    AteneaPageAnimator(page: const AcademyCreateNewPage()),
                                  );
                                },
                              ),
                            ],
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
                                  text: 'Modificar Departamento',
                                  btnStyles: const AteneaButtonStyles(
                                    backgroundColor: AppColors.primaryColor,
                                    textColor: AppColors.ateneaWhite,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      AteneaPageAnimator(page: AcademicDepartmentManageContent()),
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
}
