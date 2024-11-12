import 'package:flutter/material.dart';
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
}
