import 'package:proyect_atenea/src/domain/entities/academic_department/department_entity.dart';

abstract class DepartmentRepository {
  Future<DepartmentEntity?> getDepartment(String id);
  Future<void> saveDepartment(DepartmentEntity department);
  Future<void> deleteDepartment(String id);
  Future<List<DepartmentEntity>> getAllDepartments();
}