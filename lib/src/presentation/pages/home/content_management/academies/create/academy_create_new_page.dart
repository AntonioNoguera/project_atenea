import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/academy_contributor_row.dart';

import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/add_contributor_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/modify_contributor_dialog.dart';
 
import 'package:proyect_atenea/src/presentation/values/app_theme.dart'; 
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';

class AcademyCreateNewPage extends StatefulWidget {
  final DepartmentEntity parentDepartment;

  const AcademyCreateNewPage({super.key, required this.parentDepartment});

  @override
  _AcademyCreateNewPageState createState() => _AcademyCreateNewPageState();
}

class _AcademyCreateNewPageState extends State<AcademyCreateNewPage> {
  final TextEditingController _academyNameController = TextEditingController();
  List<Map<String, dynamic>> _contributors = []; // Lista local de contribuidores

  @override
  void dispose() {
    _academyNameController.dispose();
    super.dispose();
  }

  /// Añadir un nuevo contribuidor
  void _addContributor(UserEntity contributor, AtomicPermissionEntity permission) {
    setState(() {
      _contributors.add({
        'contributor': contributor,
        'permission': permission,
      });
    });
  }

  /// Modificar permisos de un contribuidor existente
  void _modifyContributor(int index, AtomicPermissionEntity updatedPermission) {
    setState(() {
      _contributors[index]['permission'] = updatedPermission;
    });
  }

  /// Eliminar un contribuidor de la lista local
  void _removeContributor(int index) {
    setState(() {
      _contributors.removeAt(index);
    });
  }

  /// Guardar la academia
  void _saveAcademy() {
    final academyName = _academyNameController.text.trim();
    if (academyName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El nombre de la academia no puede estar vacío.')),
      );
      return;
    }

    print('Academia guardada: $academyName');
    print('Contribuidores: ${_contributors.map((c) => c['contributor'].fullName).join(', ')}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Academia guardada con éxito')),
    );
    Navigator.pop(context);
  }

  /// Mostrar diálogo para modificar un contribuidor
  void _showModifyContributorDialog(
    int index,
    UserEntity contributor,
    AtomicPermissionEntity currentPermission,
  ) {
    showDialog(
      context: context,
      builder: (_) => ModifyContributorDialog(
        entityUUID: 'temp_academy_id',
        entityType: SystemEntitiesTypes.academy,
        userDisplayed: contributor,
        permissionEntity: currentPermission,
        onPermissionUpdated: (updatedContributor, updatedPermission) {
          _modifyContributor(index, updatedPermission);
        },
        onPermissionRemoved: (removedContributor) {
          _removeContributor(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    'Creando',
                    style: AppTextStyles.builder(
                      color: AppColors.primaryColor,
                      size: FontSizes.body2,
                      weight: FontWeights.light,
                    ),
                  ),
                  Text(
                    'Nueva Academia',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.builder(
                      color: AppColors.primaryColor,
                      size: FontSizes.h3,
                      weight: FontWeights.semibold,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'para el departamento ',
                      style: AppTextStyles.builder(
                        color: AppColors.primaryColor,
                        size: FontSizes.body2,
                        weight: FontWeights.light,
                      ),
                      children: [
                        TextSpan(
                          text: '${widget.parentDepartment.name}.',
                          style: AppTextStyles.builder(
                            color: AppColors.primaryColor,
                            size: FontSizes.body2,
                            weight: FontWeights.semibold, // Aplicar negritas al nombre del departamento
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  AteneaField(
                    placeHolder: 'Nombre de la Academia',
                    inputNameText: 'Nombre de la academia',
                    controller: _academyNameController,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Contribuidores',
                    style: AppTextStyles.builder(
                      size: FontSizes.h5,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  _contributors.isEmpty
                      ? Text(
                          'No hay ningun contribuidor para esta academia, intenta dar un de alta.',
                          style: AppTextStyles.builder(
                            size: FontSizes.body2,
                            color: AppColors.grayColor,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _contributors.length,
                            itemBuilder: (context, index) {
                              final contributor = _contributors[index]['contributor'] as UserEntity;
                              final permission = _contributors[index]['permission'] as AtomicPermissionEntity;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: AcademyContributorRow(
                                  index: index,
                                  contributorName: contributor.fullName,
                                  permissionEntity: permission,
                                  showDetail: () {
                                    _showModifyContributorDialog(index, contributor, permission);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 20.0),
                  AteneaButtonV2(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AddContributorDialog(
                          entityUUID: 'temp_academy_id',
                          entityType: SystemEntitiesTypes.academy,
                          onPermissionAdded: _addContributor,
                        ),
                      );
                    },
                    textStyle: AppTextStyles.builder(
                      color: AppColors.primaryColor,
                      size: FontSizes.h5,
                      weight: FontWeights.light,
                    ),
                    svgIcon: SvgButtonStyle(
                      svgPath: 'assets/svg/add_user.svg',
                      svgDimentions: 25,
                    ),
                    btnStyles: const AteneaButtonStyles(
                      backgroundColor: AppColors.ateneaWhite,
                      textColor: AppColors.primaryColor,
                      hasBorder: true,
                    ),
                    text: 'Añadir Contribuidor',
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    AteneaButtonV2(
                      text: 'Cancelar',
                      btnStyles: const AteneaButtonStyles(
                        backgroundColor: AppColors.secondaryColor,
                        textColor: AppColors.ateneaWhite,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: AteneaButtonV2(
                        text: 'Guardar Academia',
                        btnStyles: const AteneaButtonStyles(
                          backgroundColor: AppColors.primaryColor,
                          textColor: AppColors.ateneaWhite,
                        ),
                        onPressed: _saveAcademy,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
