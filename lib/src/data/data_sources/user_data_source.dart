// data/datasources/user_data_source.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/domain/use_cases/user_use_case.dart';

class UserDataSource {
  final FirebaseFirestore firestore;
  final String collectionName = 'users';

  UserDataSource(this.firestore);

  // Método para el login
  Future<UserEntity?> login(String fullName, String passwordHash) async {
    try {
      QuerySnapshot snapshot = await firestore.collection(collectionName)
          .where('fullName', isEqualTo: fullName)
          .where('passwordHash', isEqualTo: passwordHash)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return UserEntity.fromMap(snapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error en el login: $e');
      throw Exception('Error en el login');
    }
  }

  // Obtener un usuario por ID
  Future<UserEntity?> getUserById(String id) async {
    try {
      DocumentSnapshot doc = await firestore.collection(collectionName).doc(id).get();
      if (doc.exists) {
        return UserEntity.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error obteniendo el usuario: $e');
      return null;
    }
  }

  // Agregar un nuevo usuario
  Future<void> addUser(UserEntity user) async {
    try {
      await firestore.collection(collectionName).doc(user.id).set(user.toMap());
    } catch (e) {
      print('Error agregando el usuario: $e');
    }
  }

  // Actualizar un usuario existente
  Future<void> updateUser(UserEntity user) async {
    try {
      await firestore.collection(collectionName).doc(user.id).update(user.toMap());
    } catch (e) {
      print('Error actualizando el usuario: $e');
    }
  }

  // Eliminar un usuario
  Future<void> deleteUser(String id) async {
    try {
      await firestore.collection(collectionName).doc(id).delete();
    } catch (e) {
      print('Error eliminando el usuario: $e');
    }
  }

  // Obtener todos los usuarios
  Future<List<UserEntity>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) => UserEntity.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error obteniendo todos los usuarios: $e');
      return [];
    }
  }

  Future<PermissionEntity?> getUserPermissions(String userID) async { 
    try {
      DocumentSnapshot doc = await firestore.collection(collectionName).doc(userID).get();
      if (doc.exists) {
        return PermissionEntity.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error obteniendo el usuario: $e');
      return null;
    }
  }
}
