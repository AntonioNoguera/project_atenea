import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_checkbox_button.dart';
import 'package:proyect_atenea/src/presentation/widgets/atenea_dialog.dart';

class ModifyContributorDialog extends StatefulWidget {
  final String entityUUID;
  final SystemEntitiesTypes entityType;
  final UserEntity userDisplayed;
  final AtomicPermissionEntity permissionEntity;

  final void Function(UserEntity, AtomicPermissionEntity) onPermissionUpdated;
  final void Function(UserEntity) onPermissionRemoved;

  const ModifyContributorDialog({
    super.key,
    required this.entityUUID,
    required this.entityType,
    required this.userDisplayed,
    required this.permissionEntity,
    required this.onPermissionUpdated,
    required this.onPermissionRemoved,
  });

  @override
  _ModifyContributorDialogState createState() =>
      _ModifyContributorDialogState();
}

class _ModifyContributorDialogState extends State<ModifyContributorDialog> {
  bool canEditContent = false;
  bool canAddContributors = false;

  @override
  void initState() {
    super.initState();
    _initializePermissions();
  }

  void _initializePermissions() {
    setState(() {
      canEditContent =
          widget.permissionEntity.permissionTypes.contains(PermitTypes.edit);
      canAddContributors = widget.permissionEntity.permissionTypes
          .contains(PermitTypes.manageContributors);
    });

    // Debug: Imprimir permisos iniciales
    print('Initial permissions:');
    print('canEditContent: $canEditContent');
    print('canAddContributors: $canAddContributors');
  }

  @override
  Widget build(BuildContext context) {
    return AteneaDialog(
      title: 'Modificar Contribuidor',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Modificando permisos para ${widget.userDisplayed.fullName}',
            style: AppTextStyles.builder(
              color: AppColors.secondaryColor,
              size: FontSizes.body2,
              weight: FontWeights.semibold,
            ),
          ),
          const SizedBox(height: 10),
          AteneaCheckboxButton(
            checkboxText: 'Modificar Contenidos',
            initialState: canEditContent,
            onChanged: (value) {
              setState(() {
                canEditContent = value;
              });

              // Debug: Verificar cambios de permisos
              print('Permission updated: canEditContent = $canEditContent');
            },
          ),
          AteneaCheckboxButton(
            checkboxText: 'Añadir nuevos contribuidores',
            initialState: canAddContributors,
            onChanged: (value) {
              setState(() {
                canAddContributors = value;
              });

              // Debug: Verificar cambios de permisos
              print(
                  'Permission updated: canAddContributors = $canAddContributors');
            },
          ),
        ],
      ),
      buttonCallbacks: [
        AteneaButtonCallback(
          textButton: 'Eliminar',
          onPressedCallback: () {
            print(
                'Removing contributor: ${widget.userDisplayed.fullName}'); // Debug
            widget.onPermissionRemoved(widget.userDisplayed);
            Navigator.pop(context);
          },
          buttonStyles: const AteneaButtonStyles(
            backgroundColor: AppColors.ateneaRed,
            textColor: AppColors.ateneaWhite,
          ),
        ),
        AteneaButtonCallback(
          textButton: 'Actualizar',
          onPressedCallback: () {
            // Crear la entidad de permiso actualizada
            final updatedPermission = AtomicPermissionEntity(
              permissionId: FirebaseFirestore.instance
                  .doc('/${widget.entityType.value}/${widget.entityUUID}'),
              permissionTypes: [
                if (canEditContent) PermitTypes.edit,
                if (canAddContributors) PermitTypes.manageContributors,
              ],
            );

            // Debug: Imprimir permisos actualizados
            print('Updated permissions:');
            print('canEditContent: $canEditContent');
            print('canAddContributors: $canAddContributors');
            print('Updated AtomicPermissionEntity: ${updatedPermission.toMap()}');

            // Verificar que hay cambios antes de enviar
            if (updatedPermission.permissionTypes.isEmpty) {
              print('Error: No permissions selected.');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Debe seleccionar al menos un permiso.'),
                ),
              );
              return;
            }

            widget.onPermissionUpdated(widget.userDisplayed, updatedPermission);
            Navigator.pop(context);
          },
          buttonStyles: const AteneaButtonStyles(
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.ateneaWhite,
          ),
        ),
      ],
    );
  }
}
