import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/presentation/values/app_theme.dart';
import 'package:proyect_atenea/src/presentation/providers/remote_providers/session_provider.dart';

class AteneaPermitsRow extends StatelessWidget {
  final String uuid;
  final SystemEntitiesTypes type;

  const AteneaPermitsRow({
    Key? key,
    required this.uuid,
    required this.type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PermitTypes>>(
      future: Provider.of<SessionProvider>(context, listen: false).hasPermissionForUUID(uuid, type.value),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          // Si no tiene permisos, no mostramos los íconos
          return const Text('No tienes permisos');
        } else {
          // Mostrar íconos de permisos en función de los permisos obtenidos
          return Row( 

            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              const SizedBox(height: 6.0), 
              if (snapshot.data != null) ...[
                if (snapshot.data!.contains(PermitTypes.edit))
                  _buildPermitIcon('assets/svg/edit.svg'),

                if (snapshot.data!.contains(PermitTypes.delete))
                  _buildPermitIcon('assets/svg/trashcan.svg'),

                if (snapshot.data!.contains(PermitTypes.addContributors))
                  _buildPermitIcon('assets/svg/add_user.svg'),
              ],
            ],
          );
        }
      },
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
