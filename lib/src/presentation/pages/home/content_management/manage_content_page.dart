import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/departments/academic_department_item_row.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_circular_progress.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/department_provider.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';

class ManageContentPage extends StatelessWidget {
  const ManageContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<List<DepartmentEntity>>(
          create: (context) =>
              Provider.of<DepartmentProvider>(context, listen: false).getAllDepartments(),
          initialData: [],
        ),
      ],
      child: Consumer<List<DepartmentEntity>>(
        builder: (context, departments, child) {
          return AteneaScaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        'Administrar Contenidos',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.builder(
                          color: AppColors.primaryColor,
                          size: FontSizes.h3,
                          weight: FontWeights.semibold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      AteneaCard (
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05, 
                        ),
                        child: Column (
                          children: [
                            Text(
                              '¡Atención!',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.builder(
                                color: AppColors.ateneaBlack,
                                size: FontSizes.body1,
                                weight: FontWeights.semibold,
                              ),
                            ),
                            Text(
                              'Posees un super usuario, te permitirá editar tanto academias, como departamentos académicos, prueba entrando a un departamento académico.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.builder(
                                color: AppColors.ateneaBlack,
                                size: FontSizes.body2,
                                weight: FontWeights.regular,
                              ),
                            ),

                          ],
                        ) 
                      ), 

                      const SizedBox(height: 15),
                      Text(
                        'Departamentos Académicos Disponibles',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.builder(
                          color: AppColors.primaryColor.withOpacity(.8),
                          size: FontSizes.h5,
                          weight: FontWeights.semibold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: departments.isEmpty
                            ? const Center(
                                child: AteneaCircularProgress(),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                ),
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width * 0.05,
                                  ),
                                  itemCount: departments.length,
                                  itemBuilder: (context, index) {
                                    final department = departments[index];
                                    return AcademicDepartmentItemRow(department: department);
                                  },
                                ),
                              ),
                      ),
                      const SizedBox(height: 45.0),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    child: Row(
                      children: [
                        Expanded(
                          child: AteneaButtonV2(
                            text: 'Volver',
                            btnStyles: const AteneaButtonStyles(
                              backgroundColor: AppColors.secondaryColor,
                              textColor: AppColors.ateneaWhite,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
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
