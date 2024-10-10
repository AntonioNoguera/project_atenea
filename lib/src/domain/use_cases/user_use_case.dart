// domain/use_cases/user_use_cases.dart
import '../repositories/user_repository.dart';
import '../entities/user_entity.dart';

/// Caso de uso para obtener un usuario por ID
class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<UserEntity?> call(String id) async {
    return await repository.getUser(id);
  }
}

/// Caso de uso para agregar un nuevo usuario
class AddUser {
  final UserRepository repository;

  AddUser(this.repository);

  Future<void> call(UserEntity user) async {
    await repository.addUser(user);
  }
}

/// Caso de uso para actualizar un usuario existente
class UpdateUser {
  final UserRepository repository;

  UpdateUser(this.repository);

  Future<void> call(UserEntity user) async {
    await repository.updateUser(user);
  }
}

/// Caso de uso para eliminar un usuario por ID
class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<void> call(String id) async {
    await repository.deleteUser(id);
  }
}
