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

class AteneaContributorLocalWorkspace extends StatefulWidget {
  final String entityUUID;
  final SystemEntitiesTypes entityType;

  const AteneaContributorLocalWorkspace({
    super.key,
    required this.entityUUID,
    required this.entityType,
  });

  @override
  _AteneaContributorLocalWorkspaceState createState() =>
      _AteneaContributorLocalWorkspaceState();
}

class _AteneaContributorLocalWorkspaceState
    extends State<AteneaContributorLocalWorkspace> {
  late List<UserEntity> _contributors;
  bool _isLoading = true;

  final Map<UserEntity, AtomicPermissionEntity> _permissionsToAdd = {};
  final Map<UserEntity, AtomicPermissionEntity> _permissionsToModify = {};
  final Map<UserEntity, AtomicPermissionEntity> _permissionsToRemove = {};

  @override
  void initState() {
    super.initState();
    _fetchContributors();
  }

/*
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

      setState(() {
        _contributors = users.map((user) {
          if (user.id == currentSession?.userId) {
            return user.copyWith(fullName: '${user.fullName} (Tú)');
          }
          return user;
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
  */

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

    // Multiplica cada usuario por el número deseado de copias
    const int multiplier = 1; // Cambiar a cuántas veces se desea repetir cada usuario

    setState(() {
      _contributors = users.expand((user) {
        return List.generate(multiplier, (_) {
          // Agregar "(Tú)" al nombre si es el usuario actual
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cambios guardados con éxito')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar cambios: $e')),
      );
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
            child: Text(
              'No hay contribuidores en este departamento.',
              style: AppTextStyles.builder(
                size: FontSizes.body2,
                weight: FontWeights.regular,
                color: AppColors.grayColor,
              ),
            ),
          ),
        ] else ...[
          Expanded(
            child: ListView.builder(
              itemCount: _contributors.length,
              itemBuilder: (context, index) {
                final user = _contributors[index];
                final permission = user.userPermissions.department.isNotEmpty
                    ? user.userPermissions.department.first
                    : null;

                if (permission == null) return const SizedBox.shrink();

                return AcademyContributorRow(
                  key: ValueKey(user.id),
                  index: index,
                  contributorName: user.fullName,
                  permissionEntity: permission,
                  showDetail: () => showDialog(
                    context: context,
                    builder: (_) => ModifyContributorDialog(
                      entityUUID: widget.entityUUID,
                      permissionEntity: permission,
                      entityType: widget.entityType,
                      userDisplayed: user,
                      onPermissionUpdated: _modifyContributor,
                      onPermissionRemoved: _removeContributor,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
          ),
        ),
      ],
    );
  }

}
