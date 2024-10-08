import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/permission_entity.dart';

class SessionEntity {
  final String token;
  final UserType userLevel;
  final String fullName;
  final String passwordHash;
  final String createdAt;
  final List<PermissionEntity> userPermissions; 

  SessionEntity({
    required this.token,
    required this.userLevel,
    required this.fullName,
    required this.passwordHash,
    required this.createdAt,
    required this.userPermissions,
  });
}
