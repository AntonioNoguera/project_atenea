import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/academy_create_new_page.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/academy_item_row.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/departments/manage_content/academic_department_manage_content.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/academy_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/scroll_controller_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_folding_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_page_animator.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class AcademicDepartmentDetailPage extends StatelessWidget {
  final String departmentId;

  const AcademicDepartmentDetailPage({super.key, required this.departmentId});

  @override
  Widget build(BuildContext context) {
    final academyProvider = Provider.of<AcademyProvider>(context, listen: false);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScrollControllerNotifier()),
      ],
      child: Consumer<ScrollControllerNotifier>(
        builder: (context, scrollNotifier, child) {
          return AteneaScaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        'Informática',
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
                        textAlign: TextAlign.center,
                        'Academías Disponibles',
                        style: AppTextStyles.builder(
                          color: AppColors.primaryColor.withOpacity(.8),
                          size: FontSizes.h5,
                          weight: FontWeights.semibold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: FutureBuilder<List<AcademyEntity>>(
                          future: academyProvider.getAllAcademies(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Error al cargar academias',
                                  style: AppTextStyles.builder(
                                    color: AppColors.ateneaRed,
                                    size: FontSizes.body1,
                                  ),
                                ),
                              );
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  'No hay academias disponibles',
                                  style: AppTextStyles.builder(
                                    color: AppColors.grayColor,
                                    size: FontSizes.body1,
                                  ),
                                ),
                              );
                            } else {
                              final academies = snapshot.data!;
                              return SingleChildScrollView(
                                controller: scrollNotifier.scrollController,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width * 0.05,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      AteneaCard(
                                        child: Column(
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
                                      const SizedBox(height: 20.0),
                                      Column(
                                        children: academies.map((academy) {
                                          return AcademyItemRow(academy: academy);
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
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
