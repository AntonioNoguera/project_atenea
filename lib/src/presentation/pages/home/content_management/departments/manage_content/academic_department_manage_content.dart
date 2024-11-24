import 'package:flutter/material.dart'; 
import 'package:proyect_atenea/src/domain/entities/department_entity.dart'; 
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart'; 
import 'package:proyect_atenea/src/presentation/pages/home/content_management/widgets/atenea_contributor_local_wokspace.dart'; 
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart'; 
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart'; 

class AcademicDepartmentManageContent extends StatefulWidget {
  final DepartmentEntity department;

  const AcademicDepartmentManageContent({super.key, required this.department});

  @override
  _AcademicDepartmentManageContentState createState() =>
      _AcademicDepartmentManageContentState();
}

class _AcademicDepartmentManageContentState
    extends State<AcademicDepartmentManageContent> {
  late TextEditingController _departmentInputController;
  final GlobalKey<AteneaContributorLocalWorkspaceState> _childKey =
      GlobalKey<AteneaContributorLocalWorkspaceState>();

  @override
  void initState() {
    super.initState();
    _departmentInputController =
        TextEditingController(text: widget.department.name);
  }

  @override
  void dispose() {
    _departmentInputController.dispose();
    super.dispose();
  }

  void _invokeChildSaveChanges() { 
    _childKey.currentState?.saveChanges(context);
  }

  @override
  Widget build(BuildContext context) {
    return AteneaScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                children: [
                  Text(
                    'Modificando Departamento',
                    style: AppTextStyles.builder(
                        size: FontSizes.h3, weight: FontWeights.semibold),
                    textAlign: TextAlign.center,
                  ),
                  AteneaCard(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
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
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'Todos los cambios que realices en este departamento se verán solo reflejados hasta que se presione el botón de ',
                            style: AppTextStyles.builder(
                              color: AppColors.ateneaBlack,
                              size: FontSizes.body2,
                              weight: FontWeights.regular,
                            ),
                            children: [
                              TextSpan(
                                text: 'guardar.',
                                style: AppTextStyles.builder(
                                  color: AppColors.primaryColor.withOpacity(0.8),
                                  size: FontSizes.body2,
                                  weight: FontWeights.semibold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  AteneaField(
                    placeHolder: 'Ingresa el nombre del departamento',
                    inputNameText: 'Nombre del Departamento',
                    controller: _departmentInputController,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Contribuidores con Permisos',
                    style: AppTextStyles.builder(
                      size: FontSizes.h5,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Flexible(
                    child: AteneaContributorLocalWorkspace(
                      key: _childKey, // Asigna el GlobalKey
                      entityUUID: widget.department.id,
                      entityType: SystemEntitiesTypes.department,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  children: [
                    AteneaButtonV2(
                      text: 'Cancelar',
                      btnStyles: const AteneaButtonStyles(
                        backgroundColor: AppColors.secondaryColor,
                        textColor: AppColors.ateneaWhite,
                      ),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: AteneaButtonV2(
                        text: 'Guardar',
                        btnStyles: const AteneaButtonStyles(
                          backgroundColor: AppColors.primaryColor,
                          textColor: AppColors.ateneaWhite,
                        ),
                        onPressed: _invokeChildSaveChanges, // Invoca al método del hijo
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