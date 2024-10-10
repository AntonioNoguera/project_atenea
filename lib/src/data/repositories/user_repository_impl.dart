// data/repositories/user_repository_impl.dart 
import 'package:proyect_atenea/src/data/data_sources/user_data_source.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';

import '../../domain/repositories/user_repository.dart'; 

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity?> getUser(String id) async {
    return await dataSource.getUserFromFirestore(id);
  }

  @override
  Future<void> addUser(UserEntity user) async {
    await dataSource.addUserToFirestore(user);
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    await dataSource.updateUserInFirestore(user);
  }

  @override
  Future<void> deleteUser(String id) async {
    await dataSource.deleteUserFromFirestore(id);
  }
}
