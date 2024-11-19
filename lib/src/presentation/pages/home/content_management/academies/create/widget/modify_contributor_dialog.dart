import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/user_provider.dart';
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
      canEditContent = widget.permissionEntity.permissionTypes.contains(PermitTypes.edit);
      canAddContributors = widget.permissionEntity.permissionTypes.contains(PermitTypes.manageContributors);
    });
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
            },
          ),
          AteneaCheckboxButton(
            checkboxText: 'Añadir nuevos contribuidores',
            initialState: canAddContributors,
            onChanged: (value) {
              setState(() {
                canAddContributors = value;
              });
            },
          ),
        ],
      ),
      buttonCallbacks: [
        AteneaButtonCallback(
          textButton: 'Eliminar',
          onPressedCallback: () {
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
            final updatedPermission = AtomicPermissionEntity(
              permissionId: widget.permissionEntity.permissionId,
              permissionTypes: [
                if (canEditContent) PermitTypes.edit,
                if (canAddContributors) PermitTypes.manageContributors,
              ],
            );

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
