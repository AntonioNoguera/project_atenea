import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/widgets/atenea_contributor_local_wokspace.dart';
import 'package:proyect_atenea/src/presentation/providers/app_state_providers/active_index_notifier.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_field.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_scaffold.dart';
import 'package:proyect_atenea/src/presentation/widgets/toggle_buttons_widget%20.dart';

class SubjectCreateNewPage extends StatefulWidget {

  const SubjectCreateNewPage({super.key});
  
  @override
  _SubjectCreateNewPageState createState() => _SubjectCreateNewPageState();

}

class _SubjectCreateNewPageState extends State<SubjectCreateNewPage> {
  final TextEditingController _subjectNameController = TextEditingController();
  final GlobalKey<AteneaContributorLocalWorkspaceState> _childKey = GlobalKey<AteneaContributorLocalWorkspaceState>();

  @override
  void dispose() {
    _subjectNameController.dispose();
    super.dispose();
  }

  void _invokeChildSaveChanges() {
    if (_childKey.currentState != null) {
      _childKey.currentState!.saveChanges(context);
    }
  }

  void _handleToggle(BuildContext context, int index) {
    Provider.of<ActiveIndexNotifier>(context, listen: false).setActiveIndex(index);
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
                          'Nueva Asignatura',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.builder(
                            color: AppColors.primaryColor,
                            size: FontSizes.h3,
                            weight: FontWeights.semibold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Plan de Estudios',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.builder(
                            color: AppColors.primaryColor,
                            size: FontSizes.h5,
                            weight: FontWeights.regular,
                          ),
                        ),
                        ToggleButtonsWidget(
                          onToggle: (index) => _handleToggle(context, index),
                          toggleOptions: const ['401', '440'],
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          'Ingresa el nombre de la nueva asignatura',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.builder(
                            size: FontSizes.h5,
                            weight: FontWeights.regular,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        AteneaField(
                          placeHolder: 'Nuevo Nombre',
                          inputNameText: 'Nombres',
                          controller: _subjectNameController,
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Ingenieros con permisos',
                          style: AppTextStyles.builder(
                            size: FontSizes.h5,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Flexible(
                          child: AteneaContributorLocalWorkspace(
                            key: _childKey,
                            entityUUID: 'unique-subject-id',
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
                               
                              onPressed: _invokeChildSaveChanges, // Invoca la acción del hijo
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
