import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/departments/academic_department_item_row.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/department_provider.dart';

class ManageContentPage extends StatelessWidget {
  const ManageContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final departmentProvider = Provider.of<DepartmentProvider>(context, listen: false);

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
                Text(
                  textAlign: TextAlign.center,
                  'Posees un super usuario, te permitirá editar tanto academias, como departamentos académicos, prueba entrando a un departamento académico,',
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor,
                    size: FontSizes.body2,
                    weight: FontWeights.regular,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  textAlign: TextAlign.center,
                  'Departamentos Académicos Disponibles',
                  style: AppTextStyles.builder(
                    color: AppColors.primaryColor.withOpacity(.8),
                    size: FontSizes.h5,
                    weight: FontWeights.semibold,
                  ),
                ),
                const SizedBox(height: 10),

                // FutureBuilder para manejar el estado de carga
                Expanded(
                  child: FutureBuilder(
                    future: departmentProvider.getAllDepartments(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Mostrar un indicador de carga mientras se obtienen los datos
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error al cargar los departamentos',
                            style: AppTextStyles.builder(
                              color: AppColors.ateneaRed,
                              size: FontSizes.body2,
                              weight: FontWeights.semibold,
                            ),
                          ),
                        );
                      } else {
                        final departments = snapshot.data ?? [];
                        if (departments.isEmpty) {
                          return Center(
                            child: Text(
                              'No hay departamentos disponibles.',
                              style: AppTextStyles.builder(
                                color: AppColors.primaryColor,
                                size: FontSizes.body2,
                                weight: FontWeights.regular,
                              ),
                            ),
                          );
                        }

                        // ListView con los departamentos obtenidos
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: ListView.builder(
                            itemCount: departments.length,
                            itemBuilder: (context, index) {
                              final department = departments[index];
                              return AcademicDepartmentItemRow(department: department);
                            },
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
