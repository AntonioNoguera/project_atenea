import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/permission_entity.dart';

class UserEntity {
  final String id;
  final UserType userLevel;
  final String fullName;
  final String passwordHash;
  final String createdAt;
  final PermissionEntity userPermissions; 

  UserEntity ({
    required this.id,
    required this.userLevel,
    required this.fullName,
    required this.passwordHash,
    required this.createdAt,
    required this.userPermissions,
  });
}