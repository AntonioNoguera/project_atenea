// domain/use_cases/user_use_cases.dart

import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/user_repository.dart';

/// Caso de uso para el login de usuario
class LoginUserUseCase {
  final UserRepository repository;

  LoginUserUseCase(this.repository);

  Future<UserEntity?> call(String fullName, String passwordHash) async {
    return await repository.login(fullName, passwordHash);
  }
}

/// Caso de uso para obtener un usuario por ID
class GetUserByIdUseCase {
  final UserRepository repository;

  GetUserByIdUseCase(this.repository);

  Future<UserEntity?> call(String id) async {
    return await repository.getUserById(id);
  }
}

/// Caso de uso para agregar un nuevo usuario
class AddUserUseCase {
  final UserRepository repository;

  AddUserUseCase(this.repository);

  Future<void> call(UserEntity user) async {
    await repository.addUser(user);
  }
}

/// Caso de uso para actualizar un usuario existente
class UpdateUserUseCase {
  final UserRepository repository;

  UpdateUserUseCase(this.repository);

  Future<void> call(UserEntity user) async {
    await repository.updateUser(user);
  }
}

/// Caso de uso para eliminar un usuario por ID
class DeleteUserUseCase {
  final UserRepository repository;

  DeleteUserUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.deleteUser(id);
  }
}

/// Caso de uso para obtener todos los usuarios
class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase(this.repository);

  Future<List<UserEntity>> call() async {
    return await repository.getAllUsers();
  }
}
