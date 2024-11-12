import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';

class SubjectDataSource {
  final FirebaseFirestore firestore;
  final String collectionName = 'subjects';

  SubjectDataSource(this.firestore);
 
  Future<List<SubjectEntity>> getSubjectsFromFirestore() async {
    try {
      QuerySnapshot snapshot = await firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return SubjectEntity.fromMap(doc.id, data); // Usa fromMap para crear la entidad
      }).toList();
    } catch (e) {
      print('Error obteniendo los subjects: $e');
      return [];
    }
  }

  /// Agrega un nuevo subject a Firestore
  Future<void> addSubjectOnFirestore(SubjectEntity subject) async {
    try {
      await firestore.collection(collectionName).doc(subject.id).set(subject.toMap()); 
    } catch (e) {
      print('Error agregando el subject: $e');
    }
  }

  /// Actualiza un subject existente en Firestore
  Future<void> updateSubjectOnFirestore(SubjectEntity subject) async {
    try {
      await firestore.collection(collectionName).doc(subject.id).update(subject.toMap()); // Usa toMap para actualizar el subject
    } catch (e) {
      print('Error actualizando el subject: $e');
    }
  }

  /// Elimina un subject desde Firestore
  Future<void> deleteSubjectFromFirestore(String id) async {
    try {
      await firestore.collection(collectionName).doc(id).delete();
    } catch (e) {
      print('Error eliminando el subject: $e');
    }
  }
}
