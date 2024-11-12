import 'package:cloud_firestore/cloud_firestore.dart'; // Temp line in orde to debug
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';

class SessionEntity {
  final String token;
  final String userId;
  final PermissionEntity userPermissions;
  final DateTime tokenValidUntil;

  SessionEntity({
    required this.token,
    required this.userId,
    required this.userPermissions,
    required this.tokenValidUntil,
  });
 
  SessionEntity.defaultValues()
      : token = 'default_token',
        userId = 'default_user_id',
        userPermissions = PermissionEntity(
          isSuper: false,
          department: [
            AtomicPermissionEntity(
              permissionId: FirebaseFirestore.instance.collection('departments').doc('default_department_id'),
              permissionTypes: [PermitTypes.edit],
            ),
          ],
          academy: [],
          subject: [],
        ),
        tokenValidUntil = DateTime.now().add(const Duration(days: 30));
}
