import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/academy_contributor_row.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/add_contributor_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/modify_contributor_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/widgets/atenea_contributor_local_wokspace.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/department_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_card.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_circular_progress.dart';
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
  late List<UserEntity> _contributors;
  bool _isLoading = true;

  final Map<UserEntity, AtomicPermissionEntity> _permissionsToAdd = {};
  final Map<UserEntity, AtomicPermissionEntity> _permissionsToModify = {};
  final Map<UserEntity, AtomicPermissionEntity> _permissionsToRemove = {};

  @override
  void initState() {
    super.initState();
    _departmentInputController =
        TextEditingController(text: widget.department.name);
    _fetchContributors();
  }

  @override
  void dispose() {
    _departmentInputController.dispose();
    super.dispose();
  }

  Future<void> _fetchContributors() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final sessionProvider = Provider.of<SessionProvider>(context, listen: false);

      final currentSession = await sessionProvider.getSession(); 

      final users = await userProvider.getUsersByPermission(
        SystemEntitiesTypes.department,
        widget.department.id,
      );

      setState(() {
        _contributors = users.map((user) {
          if (user.id == currentSession?.userId) {
            return user.copyWith(fullName: '${user.fullName} (Tú)');
          }
          return user;
        }).toList();
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _contributors = [];
        _isLoading = false;
      });
    }
  }

  void _addContributor(UserEntity contributor, AtomicPermissionEntity permission) {
    setState(() {
      contributor.userPermissions.department.add(permission);
      _contributors.add(contributor);
      _permissionsToAdd[contributor] = permission;
    });
  }

  void _modifyContributor(UserEntity contributor, AtomicPermissionEntity permission) {
    setState(() {
      contributor.userPermissions.department.clear();
      contributor.userPermissions.department.add(permission);
      _permissionsToModify[contributor] = permission;
    });
  }

  void _removeContributor(UserEntity contributor) {
    setState(() {
      _contributors.remove(contributor);
      final permission = contributor.userPermissions.department.isNotEmpty
          ? contributor.userPermissions.department.first
          : AtomicPermissionEntity(
              permissionId: FirebaseFirestore.instance.doc('dummy'),
              permissionTypes: [],
            );
      _permissionsToRemove[contributor] = permission;
    });
  }

  Future<void> _saveChanges() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final departmentProvider = Provider.of<DepartmentProvider>(context, listen: false);

    try {
      for (var entry in _permissionsToAdd.entries) {
        await userProvider.addPermissionToUser(
          userId: entry.key.id,
          type: SystemEntitiesTypes.department,
          newPermission: entry.value,
        );
      }

      for (var entry in _permissionsToModify.entries) {
        if (entry.value.permissionTypes.isEmpty) {
          continue;
        }

        await userProvider.updatePermissionForUser(
          userId: entry.key.id,
          type: SystemEntitiesTypes.department,
          updatedPermission: entry.value,
        );
      }

      for (var entry in _permissionsToRemove.entries) {
        await userProvider.removePermissionFromUser(
          userId: entry.key.id,
          type: SystemEntitiesTypes.department,
          permissionId: entry.value.permissionId,
        );
      }

      final updatedDepartment = widget.department.copyWith(
        name: _departmentInputController.text,
        lastModificationDateTime: DateTime.now().toString(),
        lastModificationContributor: Provider.of<SessionProvider>(context, listen: false)
                .currentSession
                ?.userName ??
            '',
      );

      await departmentProvider.updateDepartment(updatedDepartment);

      setState(() {
        _permissionsToAdd.clear();
        _permissionsToModify.clear();
        _permissionsToRemove.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cambios guardados con éxito')),
      );

      _fetchContributors();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar cambios: $e')),
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
                        onPressed: _saveChanges,
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