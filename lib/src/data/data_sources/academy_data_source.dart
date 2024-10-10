// data/data_sources/firebase_data_source.dart

//Firestore based datasources have to be this heavy

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';

class AcademyDataSource {
  final FirebaseFirestore firestore;

  final colectionName = 'academies';

  AcademyDataSource(this.firestore);

  /// Obtiene un usuario desde Firestore basado en su ID
  Future<List<AcademyEntity?>> getAcademiesFromFirestore() async {
    try {
      DocumentSnapshot snapshot = await firestore.collection(colectionName).doc('*').get();
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        /*
        return AcademyEntity(
          id: snapshot.id,
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          age: data['age'] ?? 0,
        );
        */
        return [];
      } else {
        return [];
      }
    } catch (e) {
      print('Error obteniendo el usuario: $e');
      return [];
    }
     
  }

  /// Agrega un nuevo usuario a Firestore
  Future<void> addAcademyOnFirestore(AcademyEntity academy) async {
    try {
      await firestore.collection(colectionName).add({
        /*
        'name': user.name,
        'email': user.email,
        'age': user.age,
        */
      });
    } catch (e) {
      print('Error agregando el usuario: $e');
    }
  }

  /// Actualiza un usuario existente en Firestore
  Future<void> updateAcademyOnFirestore(AcademyEntity academy) async {
    try {
      await firestore.collection(colectionName).doc(academy.id).update({
        /*
        'name': user.name,
        'email': user.email,
        'age': user.age,
        */
      });
    } catch (e) {
      print('Error actualizando el usuario: $e');
    }
  }

  /// Elimina un usuario de Firestore basado en su ID
  Future<void> deleteAcademyFromFirestore(AcademyEntity academy) async {
    try {
      await firestore.collection(colectionName).doc(academy.id).delete();
    } catch (e) {
      print('Error eliminando el usuario: $e');
    }
  }
}
