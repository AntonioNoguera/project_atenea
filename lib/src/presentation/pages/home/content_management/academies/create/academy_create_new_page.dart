import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/widgets/atenea_contributor_local_wokspace.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/academy_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';

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
  final GlobalKey<AteneaContributorLocalWorkspaceState> _childKey =
      GlobalKey<AteneaContributorLocalWorkspaceState>();

  @override
  void dispose() {
    _academyNameController.dispose();
    super.dispose();
  }

  void _invokeChildSaveChanges() {
    _childKey.currentState?.saveChanges(context);
  }

  Future<void> _saveAcademy() async {
    final academyName = _academyNameController.text.trim();

    if (academyName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El nombre de la academia no puede estar vacío.')),
      );
      return;
    }

    // Invoca al método del widget hijo para guardar cambios locales
    _invokeChildSaveChanges();

    final parentDepartmentRef = FirebaseFirestore.instance
        .collection('departments')
        .doc(widget.parentDepartment.id);

    // Obtiene la sesión actual para recuperar el `userId`
    final sessionProvider = Provider.of<SessionProvider>(context, listen: false);
    final session = await sessionProvider.getSession();

    if (session == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo obtener la sesión del usuario.')),
      );
      return;
    }

    final newAcademy = AcademyEntity(
      name: academyName,
      parentDepartment: parentDepartmentRef,
      subjects: [], 
      lastModificationContributor: session.userId,
    );

    try {
      await Provider.of<AcademyProvider>(context, listen: false).addAcademy(newAcademy);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Academia guardada con éxito')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar la academia: $e')),
      );
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
                            weight: FontWeights.semibold,
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
                    'Contribuidores con Permisos',
                    style: AppTextStyles.builder(
                      size: FontSizes.h5,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Flexible(
                    child: AteneaContributorLocalWorkspace(
                      key: _childKey,
                      entityUUID: 'temp_academy_id',
                      entityType: SystemEntitiesTypes.academy,
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
