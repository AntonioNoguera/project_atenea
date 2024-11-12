import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';

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
        return DepartmentEntity.fromMap(doc.id, data, firestore); // Usa fromMap para crear la entidad
      }).toList();
    } catch (e) {
      print('Error obteniendo los departamentos: $e');
      return [];
    }
  }

  /// Agrega un nuevo departamento a Firestore
  Future<void> addDepartmentOnFirestore(DepartmentEntity department) async {
    try {
      await firestore.collection(collectionName).doc(department.id).set(department.toMap()); // Usa toMap para guardar el departamento
    } catch (e) {
      print('Error agregando el departamento: $e');
    }
  }

  /// Actualiza un departamento existente en Firestore
  Future<void> updateDepartmentOnFirestore(DepartmentEntity department) async {
    try {
      await firestore.collection(collectionName).doc(department.id).update(department.toMap()); // Usa toMap para actualizar el departamento
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
