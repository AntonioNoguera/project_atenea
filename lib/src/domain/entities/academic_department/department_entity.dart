import 'package:proyect_atenea/src/domain/entities/user_entity.dart';

class DepartmentEntity {
  final String id;
  final String name;  
  final List<UserEntity> usersWithPermits;
  
DepartmentEntity({
    required this.id,
    required this.name,
    required this.usersWithPermits, 
  });

  // Constructor nombrado con valores por defecto
  DepartmentEntity.defaultValues()
      : id = 'default_id',
        name = 'default_name',
        usersWithPermits = [];
}