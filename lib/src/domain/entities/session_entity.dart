import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';

class SessionEntity {
  final String token;
  final String userId;
  final String userName;
  final PermissionEntity userPermissions;
  final DateTime tokenValidUntil;
  final List<String> pinnedSubjects;

  SessionEntity({
    required this.token,
    required this.userId,
    required this.userName,
    required this.userPermissions,
    required this.tokenValidUntil,
    required this.pinnedSubjects,
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
              permissionId: FirebaseFirestore.instance
                  .collection('departments')
                  .doc('default_department_id'),
              permissionTypes: [PermitTypes.edit],
            ),
          ],
          academy: [],
          subject: [],
        ),
        tokenValidUntil = DateTime.now().add(const Duration(days: 30)),
        pinnedSubjects = [];

  // Método para convertir a un Map<String, dynamic> para almacenamiento
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'userId': userId,
      'userName': userName,
      'tokenValidUntil': tokenValidUntil.toIso8601String(),
      'isSuper': userPermissions.isSuper,
      'departmentPermissions': userPermissions.department
          .map((perm) => {
                'permissionId': perm.permissionId.path,
                'permissionTypes': perm.permissionTypes
                    .map((type) => type.toString().split('.').last)
                    .toList(),
              })
          .toList(),
      'academyPermissions': userPermissions.academy
          .map((perm) => {
                'permissionId': perm.permissionId.path,
                'permissionTypes': perm.permissionTypes
                    .map((type) => type.toString().split('.').last)
                    .toList(),
              })
          .toList(),
      'subjectPermissions': userPermissions.subject
          .map((perm) => {
                'permissionId': perm.permissionId.path,
                'permissionTypes': perm.permissionTypes
                    .map((type) => type.toString().split('.').last)
                    .toList(),
              })
          .toList(),

      // Convertimos cada DocumentReference en su path (String)
      'pinnedSubjects': pinnedSubjects.map((ref) => ref).toList(),
    };
  }

  // Método estático para crear una instancia de SessionEntity desde un mapa
  static SessionEntity fromMap(Map<String, dynamic> map) {
    try {
      return SessionEntity(
        token: map['token'] ?? 'default_token',
        userId: map['userId'] ?? 'default_user_id',
        userName: map['userName'] ?? 'default_user_name',
        tokenValidUntil: DateTime.parse(map['tokenValidUntil']),
        userPermissions: PermissionEntity(
          isSuper: map['isSuper'] ?? false,
          department: (map['departmentPermissions'] as List<dynamic>)
              .map((perm) => AtomicPermissionEntity(
                    permissionId:
                        FirebaseFirestore.instance.doc(perm['permissionId']),
                    permissionTypes: (perm['permissionTypes'] as List<dynamic>)
                        .map((type) => PermitTypes.values.firstWhere(
                              (e) => e.toString() == 'PermitTypes.$type',
                              orElse: () {
                                print(
                                    "Unknown PermitType: $type. Defaulting to 'edit'.");
                                return PermitTypes.edit;
                              },
                            ))
                        .toList(),
                  ))
              .toList(),
          academy: (map['academyPermissions'] as List<dynamic>)
              .map((perm) => AtomicPermissionEntity(
                    permissionId:
                        FirebaseFirestore.instance.doc(perm['permissionId']),
                    permissionTypes: (perm['permissionTypes'] as List<dynamic>)
                        .map((type) => PermitTypes.values.firstWhere(
                              (e) => e.toString() == 'PermitTypes.$type',
                              orElse: () {
                                print(
                                    "Unknown PermitType: $type. Defaulting to 'edit'.");
                                return PermitTypes.edit;
                              },
                            ))
                        .toList(),
                  ))
              .toList(),
          subject: (map['subjectPermissions'] as List<dynamic>)
              .map((perm) => AtomicPermissionEntity(
                    permissionId:
                        FirebaseFirestore.instance.doc(perm['permissionId']),
                    permissionTypes: (perm['permissionTypes'] as List<dynamic>)
                        .map((type) => PermitTypes.values.firstWhere(
                              (e) => e.toString() == 'PermitTypes.$type',
                              orElse: () {
                                print(
                                    "Unknown PermitType: $type. Defaulting to 'edit'.");
                                return PermitTypes.edit;
                              },
                            ))
                        .toList(),
                  ))
              .toList(),
        ),
        pinnedSubjects: (map['pinnedSubjects'] as List<dynamic>?)
                ?.map((id) => id as String)
                .toList() ??
            [],
      );
    } catch (e) {
      print("Error deserializing SessionEntity from map: $e");
      return SessionEntity
          .defaultValues(); // Retorna valores por defecto en caso de error
    }
  }
}
