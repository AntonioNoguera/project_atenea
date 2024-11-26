import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/academy_contributor_row.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/add_contributor_dialog.dart';
import 'package:proyect_atenea/src/presentation/pages/home/content_management/academies/create/widget/modify_contributor_dialog.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_button_v2.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_circular_progress.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';

class AteneaContributorLocalWorkspace extends StatefulWidget {
  final String entityUUID;
  final SystemEntitiesTypes entityType;
  final bool shouldFetchContributors;

  const AteneaContributorLocalWorkspace({
    super.key,
    required this.entityUUID,
    required this.entityType,
    this.shouldFetchContributors = true,
  });

  @override
  AteneaContributorLocalWorkspaceState createState() =>
      AteneaContributorLocalWorkspaceState();
}

class AteneaContributorLocalWorkspaceState
    extends State<AteneaContributorLocalWorkspace> {
  late List<UserEntity> _contributors;
  bool _isLoading = true;

  final Map<UserEntity, AtomicPermissionEntity> _permissionsToAdd = {};
  final Map<UserEntity, AtomicPermissionEntity> _permissionsToModify = {};
  final Map<UserEntity, AtomicPermissionEntity> _permissionsToRemove = {};

  @override
  void initState() {
    super.initState();
    if (widget.shouldFetchContributors) {
      _fetchContributors();
    } else {
      _isLoading = false;
      _contributors = [];
    }
  }

  Future<void> _fetchContributors() async {
    setState(() => _isLoading = true);

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final sessionProvider = Provider.of<SessionProvider>(context, listen: false);
      final currentSession = await sessionProvider.getSession();

      final users = await userProvider.getUsersByPermission(
        widget.entityType,
        widget.entityUUID,
      );

      const int multiplier = 1;

      setState(() {
        _contributors = users.expand((user) {
          return List.generate(multiplier, (_) {
            if (user.id == currentSession?.userId) {
              return user.copyWith(fullName: '${user.fullName} (Tú)');
            }
            return user;
          });
        }).toList();

        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _contributors = [];
        _isLoading = false;
      });
    }
  }

  void _addContributor(UserEntity contributor, AtomicPermissionEntity permission) {
    setState(() {
      switch (widget.entityType) {
        case SystemEntitiesTypes.department:
          contributor.userPermissions.department.add(permission);
          break;
        case SystemEntitiesTypes.academy:
          contributor.userPermissions.academy.add(permission);
          break;
        case SystemEntitiesTypes.subject:
          contributor.userPermissions.subject.add(permission);
          break;
      }
      _contributors.add(contributor);
      _permissionsToAdd[contributor] = permission;
    });
  }

  void _modifyContributor(UserEntity contributor, AtomicPermissionEntity permission) {
    setState(() {
      switch (widget.entityType) {
        case SystemEntitiesTypes.department:
          contributor.userPermissions.department
            ..clear()
            ..add(permission);
          break;
        case SystemEntitiesTypes.academy:
          contributor.userPermissions.academy
            ..clear()
            ..add(permission);
          break;
        case SystemEntitiesTypes.subject:
          contributor.userPermissions.subject
            ..clear()
            ..add(permission);
          break;
      }
      _permissionsToModify[contributor] = permission;
    });
  }

  void _removeContributor(UserEntity contributor) {
    setState(() {
      _contributors.remove(contributor);
      AtomicPermissionEntity permission;

      switch (widget.entityType) {
        case SystemEntitiesTypes.department:
          permission = contributor.userPermissions.department.isNotEmpty
              ? contributor.userPermissions.department.first
              : AtomicPermissionEntity(
                  permissionId: FirebaseFirestore.instance.doc('dummy'),
                  permissionTypes: [],
                );
          break;
        case SystemEntitiesTypes.academy:
          permission = contributor.userPermissions.academy.isNotEmpty
              ? contributor.userPermissions.academy.first
              : AtomicPermissionEntity(
                  permissionId: FirebaseFirestore.instance.doc('dummy'),
                  permissionTypes: [],
                );
          break;
        case SystemEntitiesTypes.subject:
          permission = contributor.userPermissions.subject.isNotEmpty
              ? contributor.userPermissions.subject.first
              : AtomicPermissionEntity(
                  permissionId: FirebaseFirestore.instance.doc('dummy'),
                  permissionTypes: [],
                );
          break;
      }

      _permissionsToRemove[contributor] = permission;
    });
  }

  Future<void> saveChanges(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      for (var entry in _permissionsToAdd.entries) {
        await userProvider.addPermissionToUser(
          userId: entry.key.id,
          type: widget.entityType,
          newPermission: entry.value,
        );
      }

      for (var entry in _permissionsToModify.entries) {
        if (entry.value.permissionTypes.isEmpty) {
          continue;
        }

        await userProvider.updatePermissionForUser(
          userId: entry.key.id,
          type: widget.entityType,
          updatedPermission: entry.value,
        );
      }

      for (var entry in _permissionsToRemove.entries) {
        await userProvider.removePermissionFromUser(
          userId: entry.key.id,
          type: widget.entityType,
          permissionId: entry.value.permissionId,
        );
      }

      setState(() {
        _permissionsToAdd.clear();
        _permissionsToModify.clear();
        _permissionsToRemove.clear();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cambios guardados con éxito')),
        );

      _fetchContributors();
      }
 
    } catch (e) {
       if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar cambios: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: AteneaCircularProgress());
    }

    return Column(
      children: [
        if (_contributors.isEmpty) ...[
          Center(
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                Text(
                  'No hay contribuidores en este departamento.',
                  style: AppTextStyles.builder(
                    size: FontSizes.body2,
                    weight: FontWeights.regular,
                    color: AppColors.grayColor,
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ] else ...[
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: _contributors.map((user) {
                  final permission = _getUserPermission(user);

                  if (permission == null) {
                    return const SizedBox.shrink();
                  }
                  return AcademyContributorRow(
                    key: ValueKey(user.id),
                    index: _contributors.indexOf(user),
                    contributorName: user.fullName,
                    permissionEntity: permission,
                    showDetail: () => showDialog(
                      context: context,
                      builder: (_) => ModifyContributorDialog(
                        entityUUID: widget.entityUUID,
                        permissionEntity: permission,
                        entityType: widget.entityType,
                        userDisplayed: user,
                        onPermissionUpdated: (userEntity, updatedPermission) =>
                            _modifyContributor(userEntity, updatedPermission),
                        onPermissionRemoved: (userEntity) =>
                            _removeContributor(userEntity),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AteneaButtonV2(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AddContributorDialog(
                entityUUID: widget.entityUUID,
                entityType: widget.entityType,
                onPermissionAdded: _addContributor,
              ),
            ),
            text: 'Añadir Contribuidor',
            btnStyles: const AteneaButtonStyles(
              backgroundColor: AppColors.ateneaWhite,
              textColor: AppColors.primaryColor,
              hasBorder: true,
            ),
            svgIcon: SvgButtonStyle(
              svgPath: 'assets/svg/add_user.svg',
              svgDimentions: 25,
            ),
            textStyle: const TextStyle(
              fontFamily: 'RadioCanada',
              color: AppColors.primaryColor,
              fontSize: FontSizes.h5,
              fontWeight: FontWeights.regular,
            ),
          ),
        ),
      ],
    );
  }

  AtomicPermissionEntity? _getUserPermission(UserEntity user) {
    switch (widget.entityType) {
      case SystemEntitiesTypes.department:
        return user.userPermissions.department.isNotEmpty
            ? user.userPermissions.department.first
            : null;
      case SystemEntitiesTypes.academy:
        return user.userPermissions.academy.isNotEmpty
            ? user.userPermissions.academy.first
            : null;
      case SystemEntitiesTypes.subject:
        return user.userPermissions.subject.isNotEmpty
            ? user.userPermissions.subject.first
            : null;
    }
  }
}
