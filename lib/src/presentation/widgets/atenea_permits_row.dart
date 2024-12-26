import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';

class AteneaPermitsRow extends StatelessWidget {
  final String uuid;
  final SystemEntitiesTypes type;

  const AteneaPermitsRow({
    Key? key,
    required this.uuid,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener los permisos del SessionProvider
    final sessionProvider = Provider.of<SessionProvider>(context, listen: false);
    final List<PermitTypes> permissions = sessionProvider.getEntityPermission(uuid, type);

    if (permissions.isEmpty) {
      return const Text('No tienes permisos');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPermitIcon('assets/svg/eye.svg'),

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
        color: AppColors.grayColor,
      ),
    );
  }
}