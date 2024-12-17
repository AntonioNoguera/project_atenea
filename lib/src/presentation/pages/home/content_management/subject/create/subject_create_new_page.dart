import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/domain/entities/content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/file_entity.dart';
import 'package:proyect_atenea/src/domain/entities/plan_content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/widgets/atenea_contributor_local_wokspace.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/subject_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';
import 'package:uuid/uuid.dart';

class SubjectCreateNewPage extends StatefulWidget {
  final AcademyEntity parentAcademy;

  const SubjectCreateNewPage({super.key, required this.parentAcademy});

  @override
  _SubjectCreateNewPageState createState() => _SubjectCreateNewPageState();
}

class _SubjectCreateNewPageState extends State<SubjectCreateNewPage> {
  final TextEditingController _subjectNameController = TextEditingController();
  final GlobalKey<AteneaContributorLocalWorkspaceState> _childKey =
      GlobalKey<AteneaContributorLocalWorkspaceState>();

  late String _candidateUUID;
  late int _activePlanIndex;

  @override
  void initState() {
    super.initState();
    _candidateUUID = const Uuid().v4();
    _activePlanIndex = 0;
  }

  @override
  void dispose() {
    _subjectNameController.dispose();
    super.dispose();
  }

  Future<void> _saveSubject() async {
    final subjectName = _subjectNameController.text.trim();
    if (subjectName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El nombre de la asignatura no puede estar vacío.')),
      );
      return;
    }

    // Determina el plan seleccionado
    final planName = _activePlanIndex == 0 ? '401' : '440';

    // Obtiene el DocumentReference de la academia padre
    final parentAcademyRef = FirebaseFirestore.instance.doc( '${SystemEntitiesTypes.academy.value}/${widget.parentAcademy.id}',);

    // Obtiene la sesión actual para recuperar el usuario
    final sessionProvider = Provider.of<SessionProvider>(context, listen: false);
    final session = await sessionProvider.getSession();
    if (session == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo obtener la sesión del usuario.')),
      );
      return;
    }

    // Crea el SubjectEntity
    final newSubject = SubjectEntity(
      id: _candidateUUID,
      name: subjectName,
      planName: planName,
      subjectPlanData: PlanContentEntity(
        subjectThemes: ContentEntity(halfTerm: HashMap<int, String>(), ordinary: HashMap<int, String>()),
        subjectFiles: HashMap<int, FileEntity>(),
      ),  
      parentAcademy: parentAcademyRef,
      lastModificationContributor: session.userId, 
    );

    // Invoca el método del hijo para guardar permisos locales
    _invokeChildSaveChanges();

    try {
      // Llama al proveedor para guardar la asignatura
      await Provider.of<SubjectProvider>(context, listen: false).addSubject(newSubject);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Asignatura guardada con éxito')),
      );
      Navigator.pop(context); // Regresa a la pantalla anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar la asignatura: $e')),
      );
    }
  }

  void _invokeChildSaveChanges() {
    if (_childKey.currentState != null) {
      _childKey.currentState!.saveChanges(context);
    }
  }

  void _handleToggle(BuildContext context, int index) {
    setState(() {
      _activePlanIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActiveIndexNotifier(),
      child: Consumer<ActiveIndexNotifier>(
        builder: (context, activeIndexNotifier, child) {
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
                          textAlign: TextAlign.center,
                          style: AppTextStyles.builder(
                            color: AppColors.primaryColor,
                            size: FontSizes.body2,
                            weight: FontWeights.regular,
                          ),
                        ),
                        Text(
                          'Nueva Asignatura',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.builder(
                            color: AppColors.primaryColor,
                            size: FontSizes.h3,
                            weight: FontWeights.semibold,
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'para la academia ',
                            style: AppTextStyles.builder(
                              color: AppColors.primaryColor,
                              size: FontSizes.body2,
                              weight: FontWeights.regular,
                            ),
                            children: [
                              TextSpan(
                                text: widget.parentAcademy.name,
                                style: AppTextStyles.builder(
                                  color: AppColors.primaryColor,
                                  size: FontSizes.body2,
                                  weight: FontWeights.semibold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Plan de Estudios',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.builder(
                            color: AppColors.primaryColor,
                            size: FontSizes.body1,
                            weight: FontWeights.semibold,
                          ),
                        ),
                        ToggleButtonsWidget(
                          onToggle: (index) => _handleToggle(context, index),
                          toggleOptions: const ['401', '440'],
                        ),
                        const SizedBox(height: 15.0),
                        AteneaField(
                          placeHolder: 'Ejemplo: Administración',
                          inputNameText: 'Nombre de la Asignatura',
                          controller: _subjectNameController,
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Contribuidores para la materia',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.builder(
                            color: AppColors.primaryColor,
                            size: FontSizes.body1,
                            weight: FontWeights.semibold,
                          ),
                        ),
                        Flexible(
                          child: AteneaContributorLocalWorkspace(
                            key: _childKey,
                            entityUUID: _candidateUUID, // Usar el UUID generado
                            entityType: SystemEntitiesTypes.subject,
                          ),
                        ),
                        const SizedBox(height: 60.0),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          AteneaButtonV2(
                            btnStyles: const AteneaButtonStyles(
                              backgroundColor: AppColors.secondaryColor,
                              textColor: AppColors.ateneaWhite,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Cancelar',
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: AteneaButtonV2(
                              onPressed: _saveSubject, // Llama al método para guardar la asignatura
                              text: 'Crear Asignatura',
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
        },
      ),
    );
  }
}
