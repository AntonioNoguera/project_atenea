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

  // Constructor nombrado con valores por defecto
  SessionEntity.defaultValues()
      : token = 'default_token',
        userId = 'default_user_id',
        userPermissions = PermissionEntity(
          isSuper: false,
          department: [],
          academy: [],
          subject: [],
        ),
        tokenValidUntil = DateTime.now().add(const Duration(days: 30));
}