import 'package:flutter/material.dart';

import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/widgets/atenea_contributor_local_wokspace.dart';

class AcademyManageContent extends StatefulWidget {
  final AcademyEntity managingAcademy;

  const AcademyManageContent({
    super.key,
    required this.managingAcademy,
  });

  @override
  _AcademyManageContentState createState() => _AcademyManageContentState();
}

class _AcademyManageContentState extends State<AcademyManageContent> {
  late TextEditingController _departmentInputController;
  final GlobalKey<AteneaContributorLocalWorkspaceState> _childKey = GlobalKey<AteneaContributorLocalWorkspaceState>();

  @override
  void initState() {
    super.initState();
    _departmentInputController = TextEditingController(text: widget.managingAcademy.name);
  }

  @override
  void dispose() {
    _departmentInputController.dispose();
    super.dispose();
  }

  void _invokeChildSaveChanges() {
    if (_childKey.currentState != null) {
      _childKey.currentState!.saveChanges(context);
    }
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
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Column(
                children: [
                  Text(
                    'Modificando Academia',
                    style: AppTextStyles.builder(
                      size: FontSizes.h3,
                      weight: FontWeights.semibold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  AteneaField(
                    placeHolder: 'Ingresa el nombre de la academia',
                    inputNameText: 'Nombre de la Academia',
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
                      key: _childKey,
                      entityUUID: widget.managingAcademy.id,
                      entityType: SystemEntitiesTypes.academy,
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
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
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
                        text: 'Guardar',
                        btnStyles: const AteneaButtonStyles(
                          backgroundColor: AppColors.primaryColor,
                          textColor: AppColors.ateneaWhite,
                        ),
                        onPressed: _invokeChildSaveChanges,
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