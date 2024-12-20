// domain/entities/user_entity.dart
import 'package:uuid/uuid.dart';

import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';

//PENDING TO FULL DEPRECATE USER LEVEL!!!

class UserEntity {
  final String id;
  final UserType userLevel;
  final String fullName;
  final String passwordHash;
  final String createdAt;
  final PermissionEntity userPermissions;

  UserEntity({
    String? id,
    required this.userLevel,
    required this.fullName,
    required this.passwordHash,
    required this.createdAt,
    required this.userPermissions,
  }) : id = id ?? const Uuid().v4(); 

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

  // Método copyWith para copiar un UserEntity con nuevos valores
  UserEntity copyWith({
    String? fullName,
    PermissionEntity? userPermissions,
  }) {
    return UserEntity(
      id: id,
      userLevel: UserType.regularUser,
      fullName: fullName ?? this.fullName,
      userPermissions: userPermissions ?? this.userPermissions, 
      passwordHash: '', createdAt: '',
    );
  }
}
