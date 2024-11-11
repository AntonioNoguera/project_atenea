// data/datasources/department_data_source.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
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
                  ?.map((user) => UserEntity.fromMap(user))
                  .toList() ??
              [],
          academies: (data['academies'] as List<dynamic>?)
                  ?.map((path) => firestore.doc(path as String))
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
      await firestore.collection(collectionName).doc(department.id).set({
        'name': department.name,
        'usersWithPermits': department.usersWithPermits.map((user) => user.toMap()).toList(),
        'academies': department.academies.map((academy) => academy.path).toList(),
        'lastModificationDateTime': department.lastModificationDateTime,
        'lastModificationContributor': department.lastModificationContributor,
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
        'usersWithPermits': department.usersWithPermits.map((user) => user.toMap()).toList(),
        'academies': department.academies.map((academy) => academy.path).toList(),
        'lastModificationDateTime': department.lastModificationDateTime,
        'lastModificationContributor': department.lastModificationContributor,
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
