import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/plan_entity.dart';

class AtomicPermissionEntity {
  final String permissionId;
  final PermitTypes permissionTypes;
   
  AtomicPermissionEntity({
    required this.permissionId,
    required this.permissionTypes,
  });
}