// data/datasources/subject_data_source.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/domain/entities/plan_content_entity.dart';

class SubjectDataSource {
  final FirebaseFirestore firestore;
  final String collectionName = 'subjects';

  SubjectDataSource(this.firestore);

  /// Obtiene todos los subjects desde Firestore
  Future<List<SubjectEntity>> getSubjectsFromFirestore() async {
    try {
      QuerySnapshot snapshot = await firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return SubjectEntity(
          id: doc.id,
          name: data['name'] ?? '',
          subjectPlanData: (data['subjectPlanData'] as List<dynamic>?)
                  ?.map((plan) => PlanContentEntity.fromMap(plan as Map<String, dynamic>))
                  .toList() ??
              [],
          lastModificationDateTime: data['lastModificationDateTime'] ?? '',
          lastModificationContributor: data['lastModificationContributor'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error obteniendo los subjects: $e');
      return [];
    }
  }

  /// Agrega un nuevo subject a Firestore
  Future<void> addSubjectOnFirestore(SubjectEntity subject) async {
    try {
      await firestore.collection(collectionName).doc(subject.id).set({
        'name': subject.name,
        'subjectPlanData': subject.subjectPlanData.map((plan) => plan.toMap()).toList(),
        'lastModificationDateTime': subject.lastModificationDateTime,
        'lastModificationContributor': subject.lastModificationContributor,
      });
    } catch (e) {
      print('Error agregando el subject: $e');
    }
  }

  /// Actualiza un subject existente en Firestore
  Future<void> updateSubjectOnFirestore(SubjectEntity subject) async {
    try {
      await firestore.collection(collectionName).doc(subject.id).update({
        'name': subject.name,
        'subjectPlanData': subject.subjectPlanData.map((plan) => plan.toMap()).toList(),
        'lastModificationDateTime': subject.lastModificationDateTime,
        'lastModificationContributor': subject.lastModificationContributor,
      });
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
