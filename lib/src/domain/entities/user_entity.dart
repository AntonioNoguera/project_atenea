// domain/entities/user_entity.dart

import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';

class UserEntity {
  final String id;
  final UserType userLevel;
  final String fullName;
  final String passwordHash;
  final String createdAt;
  final PermissionEntity userPermissions;

  UserEntity({
    required this.id,
    required this.userLevel,
    required this.fullName,
    required this.passwordHash,
    required this.createdAt,
    required this.userPermissions,
  });

  // Método fromMap para convertir datos de Firestore a UserEntity
  factory UserEntity.fromMap(Map<String, dynamic> data) {
    return UserEntity(
      id: data['id'] ?? '',
      userLevel: UserType.values.firstWhere(
        (e) => e.toString() == 'UserType.${data['userLevel']}',
        orElse: () => UserType.regularUser,
      ),
      fullName: data['fullName'] ?? '',
      passwordHash: data['passwordHash'] ?? '',
      createdAt: data['createdAt'] ?? '',
      userPermissions: PermissionEntity.fromMap(data['userPermissions'] as Map<String, dynamic>? ?? {}),
    );
  }

  // Método toMap para convertir UserEntity a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userLevel': userLevel.toString().split('.').last,
      'fullName': fullName,
      'passwordHash': passwordHash,
      'createdAt': createdAt,
      'userPermissions': userPermissions.toMap(),
    };
  }
}
