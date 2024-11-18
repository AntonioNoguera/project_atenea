import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';

class AteneaAtomicPermitsRow extends StatelessWidget {
  final AtomicPermissionEntity permissionEntity; 
  final Color color;

  const AteneaAtomicPermitsRow({
    Key? key,
    required this.permissionEntity,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtén los permisos individuales desde `AtomicPermissionEntity`
    final List<PermitTypes> permissions = permissionEntity.permissionTypes;

    if (permissions.isEmpty) {
      // Si no hay permisos, muestra un mensaje indicando que no hay permisos
      return Text(
        'N / A',
        style: AppTextStyles.builder(
          color: color,
          size: FontSizes.body2,
          weight: FontWeights.semibold,
        ),
        );
    }

    // Renderiza los íconos en función de los permisos
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícono para "ver" siempre presente
            _buildPermitIcon('assets/svg/eye.svg'),

            // Verifica cada tipo de permiso y muestra el ícono correspondiente
            if (permissions.contains(PermitTypes.edit))
              _buildPermitIcon('assets/svg/edit.svg'),

            if (permissions.contains(PermitTypes.manageContributors))
              _buildPermitIcon('assets/svg/add_user.svg'),

            if (permissions.contains(PermitTypes.delete))
              _buildPermitIcon('assets/svg/trashcan.svg'),
          ],
        ),
      ],
    );
  }

  Widget _buildPermitIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SvgPicture.asset(
        assetPath,
        width: 24,
        height: 24,
        color: color,
      ),
    );
  }
}
