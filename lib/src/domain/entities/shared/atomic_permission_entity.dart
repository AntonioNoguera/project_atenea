import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';

class AtomicPermissionEntity {
  final DocumentReference permissionId;
  final List<PermitTypes> permissionTypes;

  AtomicPermissionEntity({
    required this.permissionId,
    required this.permissionTypes,
  });
 
  factory AtomicPermissionEntity.fromMap(Map<String, dynamic> data) { 
    final List<PermitTypes> permissions = (data['permissionTypes'] as List<dynamic>?)
        ?.map((type) => PermitTypes.values.firstWhere(
              (e) => e.toString() == 'PermitTypes.$type',
              orElse: () => PermitTypes.edit,
            ))
        .toList() ??
        [];

    return AtomicPermissionEntity(
      permissionId: data['permissionId'] as DocumentReference, 
      permissionTypes: permissions,
    );
  }
 
  Map<String, dynamic> toMap() {
    return {
      'permissionId': permissionId,
      'permissionTypes': permissionTypes.map((type) => type.toString().split('.').last).toList(),
    };
  }
}
