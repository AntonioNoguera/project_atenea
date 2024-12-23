// domain/repositories/user_repository.dart

import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> login(String fullName, String passwordHash);
  Future<UserEntity?> getUserById(String id);
  Future<void> addUser(UserEntity user);
  Future<void> updateUser(UserEntity user);
  Future<void> deleteUser(String id);
  Future<List<UserEntity>> getAllUsers();
  Future<PermissionEntity?> getUserPermissions(String userID);
}