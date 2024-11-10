import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/academic_department/department_entity.dart';
import 'package:proyect_atenea/src/domain/entities/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/permission_entity.dart'; 
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';

class DepartmentDataSource {
  final FirebaseFirestore firestore;
  final String collectionName = 'departments';

  DepartmentDataSource(this.firestore);

  /// Obtiene todos los departamentos desde Firestore
  Future<List<DepartmentEntity>> getDepartmentsFromFirestore() async {
    try {
      QuerySnapshot snapshot = await firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return DepartmentEntity(
          id: doc.id,
          name: data['name'] ?? '',
          usersWithPermits: (data['usersWithPermits'] as List<dynamic>?)
                  ?.map((user) => UserEntity(
                        id: user['id'] ?? '',
                        userLevel: UserType.values.firstWhere(
                          (e) => e.toString() == 'UserType.${user['userLevel']}',
                          orElse: () => UserType.regularUser,
                        ),
                        fullName: user['fullName'] ?? '',
                        passwordHash: user['passwordHash'] ?? '',
                        createdAt: user['createdAt'] ?? '',
                        userPermissions: PermissionEntity(
                          isSuper: user['userPermissions']['isSuper'] ?? false,
                          department: (user['userPermissions']['department'] as List<dynamic>?)
                                  ?.map((perm) => AtomicPermissionEntity(
                                        permissionId: perm['permissionId'] ?? '',
                                        permissionTypes: PermitTypes.values.firstWhere(
                                          (e) => e.toString() == 'PermitTypes.${perm['permissionTypes']}',
                                          orElse: () => PermitTypes.edit,
                                        ),
                                      ))
                                  .toList() ??
                              [],
                          academy: (user['userPermissions']['academy'] as List<dynamic>?)
                                  ?.map((perm) => AtomicPermissionEntity(
                                        permissionId: perm['permissionId'] ?? '',
                                        permissionTypes: PermitTypes.values.firstWhere(
                                          (e) => e.toString() == 'PermitTypes.${perm['permissionTypes']}',
                                          orElse: () => PermitTypes.edit,
                                        ),
                                      ))
                                  .toList() ??
                              [],
                          subject: (user['userPermissions']['subject'] as List<dynamic>?)
                                  ?.map((perm) => AtomicPermissionEntity(
                                        permissionId: perm['permissionId'] ?? '',
                                        permissionTypes: PermitTypes.values.firstWhere(
                                          (e) => e.toString() == 'PermitTypes.${perm['permissionTypes']}',
                                          orElse: () => PermitTypes.edit,
                                        ),
                                      ))
                                  .toList() ??
                              [],
                        ),
                      ))
                  .toList() ??
              [],
        );
      }).toList();
    } catch (e) {
      print('Error obteniendo los departamentos: $e');
      return [];
    }
  }

  /// Agrega un nuevo departamento a Firestore
  Future<void> addDepartmentOnFirestore(DepartmentEntity department) async {
    try {
      await firestore.collection(collectionName).add({
        'name': department.name,
        'usersWithPermits': department.usersWithPermits
            .map((user) => {
                  'id': user.id,
                  'userLevel': user.userLevel.toString().split('.').last,
                  'fullName': user.fullName,
                  'passwordHash': user.passwordHash,
                  'createdAt': user.createdAt,
                  'userPermissions': {
                    'isSuper': user.userPermissions.isSuper,
                    'department': user.userPermissions.department
                        .map((perm) => {
                              'permissionId': perm.permissionId,
                              'permissionTypes': perm.permissionTypes.toString().split('.').last,
                            })
                        .toList(),
                    'academy': user.userPermissions.academy
                        .map((perm) => {
                              'permissionId': perm.permissionId,
                              'permissionTypes': perm.permissionTypes.toString().split('.').last,
                            })
                        .toList(),
                    'subject': user.userPermissions.subject
                        .map((perm) => {
                              'permissionId': perm.permissionId,
                              'permissionTypes': perm.permissionTypes.toString().split('.').last,
                            })
                        .toList(),
                  },
                })
            .toList(),
      });
    } catch (e) {
      print('Error agregando el departamento: $e');
    }
  }

  /// Actualiza un departamento existente en Firestore
  Future<void> updateDepartmentOnFirestore(DepartmentEntity department) async {
    try {
      await firestore.collection(collectionName).doc(department.id).update({
        'name': department.name,
        'usersWithPermits': department.usersWithPermits
            .map((user) => {
                  'id': user.id,
                  'userLevel': user.userLevel.toString().split('.').last,
                  'fullName': user.fullName,
                  'passwordHash': user.passwordHash,
                  'createdAt': user.createdAt,
                  'userPermissions': {
                    'isSuper': user.userPermissions.isSuper,
                    'department': user.userPermissions.department
                        .map((perm) => {
                              'permissionId': perm.permissionId,
                              'permissionTypes': perm.permissionTypes.toString().split('.').last,
                            })
                        .toList(),
                    'academy': user.userPermissions.academy
                        .map((perm) => {
                              'permissionId': perm.permissionId,
                              'permissionTypes': perm.permissionTypes.toString().split('.').last,
                            })
                        .toList(),
                    'subject': user.userPermissions.subject
                        .map((perm) => {
                              'permissionId': perm.permissionId,
                              'permissionTypes': perm.permissionTypes.toString().split('.').last,
                            })
                        .toList(),
                  },
                })
            .toList(),
      });
    } catch (e) {
      print('Error actualizando el departamento: $e');
    }
  }

  /// Elimina un departamento desde Firestore
  Future<void> deleteDepartmentFromFirestore(String id) async {
    try {
      await firestore.collection(collectionName).doc(id).delete();
    } catch (e) {
      print('Error eliminando el departamento: $e');
    }
  }
}