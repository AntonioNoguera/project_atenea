import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';

class SessionEntity {
  final String token;
  final String userId;
  final String userName;
  final PermissionEntity userPermissions;
  final DateTime tokenValidUntil;

  SessionEntity({
    required this.token,
    required this.userId,
    required this.userName,
    required this.userPermissions,
    required this.tokenValidUntil,
  });

  // Constructor con valores predeterminados
  SessionEntity.defaultValues()
      : token = 'default_token',
        userId = 'default_user_id',
        userName = 'default_user_name',
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

  // Método para convertir a un Map<String, dynamic> para almacenamiento
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'userId': userId,
      'userName': userName,
      'tokenValidUntil': tokenValidUntil.toIso8601String(),
      // Guardamos solo permisos básicos en un formato simplificado para almacenarlos
      'isSuper': userPermissions.isSuper,
      'departmentPermissions': userPermissions.department
          .map((perm) => perm.permissionId.path)
          .toList(),
      'academyPermissions': userPermissions.academy
          .map((perm) => perm.permissionId.path)
          .toList(),
      'subjectPermissions': userPermissions.subject
          .map((perm) => perm.permissionId.path)
          .toList(),
    };
  }

  // Método estático para crear una instancia de SessionEntity desde un mapa
  static SessionEntity fromMap(Map<String, dynamic> map) {
    return SessionEntity(
      token: map['token'] ?? 'default_token',
      userId: map['userId'] ?? 'default_user_id',
      userName: map['userName'] ?? 'default_user_name',
      tokenValidUntil: DateTime.parse(map['tokenValidUntil']),
      userPermissions: PermissionEntity(
        isSuper: map['isSuper'] ?? false,
        department: (map['departmentPermissions'] as List<String>)
            .map((path) => AtomicPermissionEntity(
                  permissionId: FirebaseFirestore.instance.doc(path),
                  permissionTypes: [PermitTypes.edit],
                ))
            .toList(),
        academy: (map['academyPermissions'] as List<String>)
            .map((path) => AtomicPermissionEntity(
                  permissionId: FirebaseFirestore.instance.doc(path),
                  permissionTypes: [PermitTypes.edit],
                ))
            .toList(),
        subject: (map['subjectPermissions'] as List<String>)
            .map((path) => AtomicPermissionEntity(
                  permissionId: FirebaseFirestore.instance.doc(path),
                  permissionTypes: [PermitTypes.edit],
                ))
            .toList(),
      ),
    );
  }
}
