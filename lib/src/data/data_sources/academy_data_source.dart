// data/datasources/academy_data_source.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart'; 
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';

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
        return AcademyEntity(
          id: doc.id,
          name: data['name'] ?? '',
          autorizedAdmins: (data['autorizedAdmins'] as List<dynamic>?)
                  ?.map((admin) => UserEntity.fromMap(admin))
                  .toList() ??
              [],
        );
      }).toList();
    } catch (e) {
      print('Error obteniendo las academias: $e');
      return [];
    }
  }

  /// Agrega una nueva academia a Firestore
  Future<void> addAcademyOnFirestore(AcademyEntity academy) async {
    try {
      await firestore.collection(collectionName).doc(academy.id).set({
        'name': academy.name,
        'autorizedAdmins': academy.autorizedAdmins.map((admin) => admin.toMap()).toList(),
        'subjects': academy.subjects.map((subject) => subject.path).toList(),
        'lastModificationDateTime': academy.lastModificationDateTime,
        'lastModificationContributor': academy.lastModificationContributor,
      });
    } catch (e) {
      print('Error agregando la academia: $e');
    }
  }

  /// Actualiza una academia existente en Firestore
  Future<void> updateAcademyOnFirestore(AcademyEntity academy) async {
    try {
      await firestore.collection(collectionName).doc(academy.id).update({
        'name': academy.name,
        'autorizedAdmins': academy.autorizedAdmins.map((admin) => admin.toMap()).toList(),
        'subjects': academy.subjects.map((subject) => subject.path).toList(),
        'lastModificationDateTime': academy.lastModificationDateTime,
        'lastModificationContributor': academy.lastModificationContributor,
      });
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
}
