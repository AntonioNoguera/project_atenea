import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';

class AcademyDataSource {
  final FirebaseFirestore firestore;
  final String collectionName = 'academies';

  AcademyDataSource(this.firestore);

  /// Obtiene todas las academias desde Firestore
  Future<List<AcademyEntity>> getAcademiesFromFirestore() async {
    try {
      QuerySnapshot snapshot = await firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return AcademyEntity.fromMap(data, doc.id, firestore); // Agrega firestore como tercer argumento
      }).toList();
    } catch (e) {
      print('Error obteniendo las academias: $e');
      return [];
    }
  }


  /// Agrega una nueva academia a Firestore
  Future<void> addAcademyOnFirestore(AcademyEntity academy) async {
    try {
      await firestore.collection(collectionName).doc(academy.id).set(academy.toMap()); // Usa toMap actualizado
    } catch (e) {
      print('Error agregando la academia: $e');
    }
  }

  /// Actualiza una academia existente en Firestore
  Future<void> updateAcademyOnFirestore(AcademyEntity academy) async {
    try {
      await firestore.collection(collectionName).doc(academy.id).update(academy.toMap()); // Usa toMap actualizado
    } catch (e) {
      print('Error actualizando la academia: $e');
    }
  }

  /// Elimina una academia desde Firestore
  Future<void> deleteAcademyFromFirestore(String id) async {
    try {
      await firestore.collection(collectionName).doc(id).delete();
    } catch (e) {
      print('Error eliminando la academia: $e');
    }
  }

  Future<List<AcademyEntity>> getAcademiesByDepartmentId(String departmentId) async {
    try {
      final querySnapshot = await firestore
          .collection('academies')
          .where('parentDepartment', isEqualTo: firestore.doc('departments/$departmentId').path)
          .get();

      return querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return AcademyEntity.fromMap(data, doc.id, firestore); // Agrega firestore y doc.id
      }).toList();
    } catch (e) {
      print('Error obteniendo academias por departmentId: $e');
      return [];
    }
  }
}
