import 'package:proyect_atenea/src/domain/entities/department_entity.dart';

abstract class DepartmentRepository {
  Future<DepartmentEntity?> getDepartment(String id);
  Future<void> saveDepartment(DepartmentEntity department);
  Future<void> updateDepartment(DepartmentEntity department); // Método de actualización añadido
  Future<void> deleteDepartment(String id);
  Future<List<DepartmentEntity>> getAllDepartments();
}
