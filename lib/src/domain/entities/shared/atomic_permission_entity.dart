// domain/entities/atomic_permission_entity.dart

import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';

class AtomicPermissionEntity {
  final String permissionId;
  final PermitTypes permissionTypes;

  AtomicPermissionEntity({
    required this.permissionId,
    required this.permissionTypes,
  });

  // Método fromMap para convertir datos de Firestore a AtomicPermissionEntity
  factory AtomicPermissionEntity.fromMap(Map<String, dynamic> data) {
    return AtomicPermissionEntity(
      permissionId: data['permissionId'] ?? '',
      permissionTypes: PermitTypes.values.firstWhere(
        (e) => e.toString() == 'PermitTypes.${data['permissionTypes']}',
        orElse: () => PermitTypes.edit,
      ),
    );
  }

  // Método toMap para convertir AtomicPermissionEntity a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'permissionId': permissionId,
      'permissionTypes': permissionTypes.toString().split('.').last,
    };
  }
}
