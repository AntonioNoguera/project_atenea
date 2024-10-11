import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/permission_entity.dart';

class SessionEntity {
  final String token;
  final String userId; 
  final List<PermissionEntity> userPermissions;
  final DateTime tokenValidUntil;


  SessionEntity({
    required this.token,
    required this.userId, 
    required this.userPermissions,
    required this.tokenValidUntil,
  });
}
