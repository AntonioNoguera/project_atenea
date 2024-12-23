import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/domain/use_cases/user_use_case.dart';

class UserProvider with ChangeNotifier {
  final LoginUserUseCase loginUserUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;
  final AddUserUseCase addUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetUserPermissionsUseCase getUserPermissionsUseCase;

  UserProvider({
    required this.loginUserUseCase,
    required this.getUserByIdUseCase,
    required this.addUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
    required this.getAllUsersUseCase,
    required this.getUserPermissionsUseCase
  });

  UserEntity? _currentUser = null;

  List<UserEntity> _users = [];
  String? _errorMessage;

  List<UserEntity> get users => _users;
  String? get errorMessage => _errorMessage;

  // Login
  Future<UserEntity?> loginUser(String fullName, String passwordHash) async {
    try {
      final user = await loginUserUseCase.call(fullName, passwordHash);
      _errorMessage = user == null ? 'Usuario o contraseña incorrectos' : null;
      notifyListeners();
      return user;
    } catch (e) {
      _errorMessage = 'Error durante el login';
      notifyListeners();
      return null;
    }
  }

  // Obtener usuario por ID
  Future<UserEntity?> getUserById(String id) async {
    try {
      final user = await getUserByIdUseCase.call(id);
      _errorMessage = null;
      return user;
    } catch (e) {
      _errorMessage = 'Error obteniendo el usuario';
      notifyListeners();
      return null;
    }
  }

  // Agregar un nuevo usuario
  Future<void> addUser(UserEntity user) async {
    try {
      await addUserUseCase.call(user);
      await getAllUsers();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al agregar el usuario';
      notifyListeners();
    }
  }

  // Actualizar usuario existente
  Future<void> updateUser(UserEntity user) async {
    try {
      await updateUserUseCase.call(user);
      await getAllUsers();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al actualizar el usuario';
      notifyListeners();
    }
  }

  // Eliminar un usuario por ID
  Future<void> deleteUser(String id) async {
    try {
      await deleteUserUseCase.call(id);
      await getAllUsers();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al eliminar el usuario';
      notifyListeners();
    }
  }

  // Obtener todos los usuarios
  Future<List<UserEntity>> getAllUsers() async {
    try {
      _users = await getAllUsersUseCase.call();
      _errorMessage = null;
      notifyListeners();
      return _users;
    } catch (e) {
      _errorMessage = 'Error al obtener la lista de usuarios';
      notifyListeners();
      return [];
    }
  }

  // Obtener usuarios por permisos
  Future<List<UserEntity>> getUsersByPermission(SystemEntitiesTypes type, String entityId) async {
    final users = await getAllUsers();
    return users.where((user) {
      final permissions = _getPermissionList(user, type);
      final hasValidPermission = permissions.any((perm) => perm.permissionId.path == '${type.value}/$entityId');
      return hasValidPermission;
    }).toList();
  }

  // Añadir permiso a un usuario
  Future<void> addPermissionToUser({
    required String userId,
    required SystemEntitiesTypes type,
    required AtomicPermissionEntity newPermission,
  }) async {
    try {
      final user = await getUserById(userId);
      if (user == null) throw Exception('Usuario no encontrado con ID: $userId');

      final permissions = _getPermissionList(user, type);
      if (!permissions.any((perm) => perm.permissionId == newPermission.permissionId)) {
        permissions.add(newPermission);
        await updateUser(user);
        notifyListeners();
        print('Permiso añadido exitosamente al usuario ${user.fullName}');
      }
    } catch (e) {
      print('Error al añadir permiso al usuario: $e');
      rethrow;
    }
  }

  // Eliminar permiso de un usuario
  Future<void> removePermissionFromUser({
    required String userId,
    required SystemEntitiesTypes type,
    required DocumentReference permissionId,
  }) async {
    try {
      final user = await getUserById(userId);
      if (user == null) throw Exception('Usuario no encontrado con ID: $userId');

      final permissions = _getPermissionList(user, type);
      permissions.removeWhere((perm) => perm.permissionId == permissionId);

      await updateUser(user);
      notifyListeners();
      print('Permiso eliminado exitosamente del usuario ${user.fullName}');
    } catch (e) {
      print('Error al eliminar permiso del usuario: $e');
      throw Exception('Failed to remove permission');
    }
  }

  // Actualizar permiso de un usuario
  Future<void> updatePermissionForUser({
    required String userId,
    required SystemEntitiesTypes type,
    required AtomicPermissionEntity updatedPermission,
  }) async {
    try {
      print('Iniciando actualización de permisos para usuario: $userId');

      // Eliminar permiso existente
      await removePermissionFromUser(
        userId: userId,
        type: type,
        permissionId: updatedPermission.permissionId,
      );

      // Añadir el nuevo permiso
      await addPermissionToUser(
        userId: userId,
        type: type,
        newPermission: updatedPermission,
      );

      print('Permiso actualizado correctamente para el usuario $userId');
    } catch (e) {
      print('Error al actualizar permisos para el usuario $userId: $e');
      throw Exception('Failed to update permission');
    }
  }

  // Obtener la lista de permisos del tipo correspondiente
  List<AtomicPermissionEntity> _getPermissionList(UserEntity user, SystemEntitiesTypes type) {
    switch (type) {
      case SystemEntitiesTypes.department:
        return user.userPermissions.department;
      case SystemEntitiesTypes.academy:
        return user.userPermissions.academy;
      case SystemEntitiesTypes.subject:
        return user.userPermissions.subject;
    }
  }

  void getUserPermissions(String userID) {
    getUserPermissionsUseCase.call(userID).then((permissions) {
      if (permissions != null) {
        _currentUser!.userPermissions = permissions;
      }
      
      notifyListeners();
    });
  }
}