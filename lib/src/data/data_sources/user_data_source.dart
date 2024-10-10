// data/data_sources/firebase_data_source.dart

//Firestore based datasources have to be this heavy

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

class UserDataSource {
  final FirebaseFirestore firestore;

  UserDataSource(this.firestore);

  /// Obtiene un usuario desde Firestore basado en su ID
  Future<UserEntity?> getUserFromFirestore(String userId) async {
    try {
      DocumentSnapshot snapshot = await firestore.collection('users').doc(userId).get();
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        /*
        return UserEntity(
          id: snapshot.id,
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          age: data['age'] ?? 0,
        );
        */
      } else {
        return null;
      }
    } catch (e) {
      print('Error obteniendo el usuario: $e');
      return null;
    }
  }

  /// Agrega un nuevo usuario a Firestore
  Future<void> addUserToFirestore(UserEntity user) async {
    try {
      await firestore.collection('users').add({
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
  Future<void> updateUserInFirestore(UserEntity user) async {
    try {
      await firestore.collection('users').doc(user.id).update({
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
  Future<void> deleteUserFromFirestore(String userId) async {
    try {
      await firestore.collection('users').doc(userId).delete();
    } catch (e) {
      print('Error eliminando el usuario: $e');
    }
  }
}
