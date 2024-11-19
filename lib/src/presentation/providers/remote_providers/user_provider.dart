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

  UserProvider({
    required this.loginUserUseCase,
    required this.getUserByIdUseCase,
    required this.addUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
    required this.getAllUsersUseCase,
  });

  List<UserEntity> _users = [];
  String? _errorMessage;

  List<UserEntity> get users => _users;
  String? get errorMessage => _errorMessage;

  // Método de login que retorna UserEntity? en lugar de void
  Future<UserEntity?> loginUser(String fullName, String passwordHash) async {
    try {
      final user = await loginUserUseCase.call(fullName, passwordHash);
      if (user == null) {
        _errorMessage = 'Usuario o contraseña incorrectos';
      } else {
        _errorMessage = null;
      }
      notifyListeners();

      

      return user; // Retorna el usuario autenticado o null
    } catch (e) {
      _errorMessage = 'Error durante el login';
      notifyListeners();
      return null;
    }
  }

  // Obtener un usuario por ID
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
      await getAllUsers(); // Actualiza la lista de usuarios
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al agregar el usuario';
      notifyListeners();
    }
  }

  // Actualizar un usuario existente
  Future<void> updateUser(UserEntity user) async {
    try {
      await updateUserUseCase.call(user);
      await getAllUsers(); // Actualiza la lista de usuarios
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
      await getAllUsers(); // Actualiza la lista de usuarios
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al eliminar el usuario';
      notifyListeners();
    }
  }

  // Modificación en UserProvider
  Future<List<UserEntity>> getAllUsers() async {
    try {
      _users = await getAllUsersUseCase.call();
      _errorMessage = null;
      notifyListeners();
      return _users; // Retorna la lista de usuarios
    } catch (e) {
      _errorMessage = 'Error al obtener la lista de usuarios';
      notifyListeners();
      return [];
    }
  }

  Future<List<UserEntity>> getUsersByPermission(SystemEntitiesTypes type, String entityId) async {
    _users = await getAllUsers(); // Actualiza la lista de usuarios

    return _users.where((user) {
      // Obtener los permisos de la entidad correspondiente
      List<AtomicPermissionEntity> permissions = [];
      switch (type) {
        case SystemEntitiesTypes.department:
          permissions = user.userPermissions.department;
          break;
        case SystemEntitiesTypes.academy:
          permissions = user.userPermissions.academy;
          break;
        case SystemEntitiesTypes.subject:
          permissions = user.userPermissions.subject;
          break;
      }

      // Filtrar los permisos que coinciden con el ID
      final filteredPermissions = permissions.where((perm) {
        return perm.permissionId.path == '${type.value}/$entityId';
      }).toList();

      // Actualizar los permisos del usuario con los permisos filtrados
      if (filteredPermissions.isNotEmpty) {
        if (type == SystemEntitiesTypes.department) {
          user.userPermissions.department = filteredPermissions;
        } else if (type == SystemEntitiesTypes.academy) {
          user.userPermissions.academy = filteredPermissions;
        } else if (type == SystemEntitiesTypes.subject) {
          user.userPermissions.subject = filteredPermissions;
        }
        return true; // El usuario tiene al menos un permiso válido
      }

      return false; // El usuario no tiene permisos válidos para esta entidad
    }).toList();
  }

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

  //
  Future<void> addPermissionToUser({
    required String userId,
    required SystemEntitiesTypes type,
    required AtomicPermissionEntity newPermission,
  }) async {
    try {
      final user = await getUserById(userId);
      if (user == null) throw Exception('Usuario no encontrado con ID: $userId');

      final permissions = _getPermissionList(user, type);

      // Verificar duplicados antes de añadir
      if (!permissions.any((perm) => perm.permissionId == newPermission.permissionId)) {
        permissions.add(newPermission);
      }

      await updateUser(user);
      notifyListeners();
      print('Permiso añadido exitosamente al usuario ${user.fullName}');
    } catch (e) {
      print('Error al añadir permiso al usuario: $e');
      rethrow;
    }
  }


  Future<void> removePermissionFromUser({
    required String userId,
    required SystemEntitiesTypes type,
    required DocumentReference permissionId,
  }) async {
    try {
      final user = await getUserById(userId);
      if (user == null) throw Exception('Usuario no encontrado con ID: $userId');

      final permissions = _getPermissionList(user, type);

      // Eliminar el permiso si existe
      permissions.removeWhere((perm) => perm.permissionId == permissionId);

      await updateUser(user);
      notifyListeners();
      print('Permiso eliminado exitosamente del usuario ${user.fullName}');
    } catch (e) {
      print('Error al eliminar permiso del usuario: $e');
      throw Exception('Failed to remove permission');
    }
  }


}