import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getUser(String id);
  Future<void> addUser(UserEntity userInstance);
  Future<void> updateUser(UserEntity userInstance);
  Future<void> deleteUser(String id);
}