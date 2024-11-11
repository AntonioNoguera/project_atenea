// data/repositories/user_repository_impl.dart
 
import 'package:proyect_atenea/src/data/data_sources/user_data_source.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity?> login(String fullName, String passwordHash) async {
    return await dataSource.login(fullName, passwordHash);
  }

  @override
  Future<UserEntity?> getUserById(String id) async {
    return await dataSource.getUserById(id);
  }

  @override
  Future<void> addUser(UserEntity user) async {
    await dataSource.addUser(user);
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    await dataSource.updateUser(user);
  }

  @override
  Future<void> deleteUser(String id) async {
    await dataSource.deleteUser(id);
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    return await dataSource.getAllUsers();
  }
}
