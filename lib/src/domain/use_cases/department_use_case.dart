import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/department_repository.dart';

class GetDepartmentUseCase {
  final DepartmentRepository repository;

  GetDepartmentUseCase(this.repository);

  Future<DepartmentEntity?> call(String id) async {
    return await repository.getDepartment(id);
  }
}

class SaveDepartmentUseCase {
  final DepartmentRepository repository;

  SaveDepartmentUseCase(this.repository);

  Future<void> call(DepartmentEntity department) async {
    return await repository.saveDepartment(department);
  }
}

class UpdateDepartmentUseCase {
  final DepartmentRepository repository;

  UpdateDepartmentUseCase(this.repository);

  Future<void> call(DepartmentEntity department) async {
    return await repository.updateDepartment(department);
  }
}

class DeleteDepartmentUseCase {
  final DepartmentRepository repository;

  DeleteDepartmentUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteDepartment(id);
  }
}

class GetAllDepartmentsUseCase {
  final DepartmentRepository repository;

  GetAllDepartmentsUseCase(this.repository);

  Future<List<DepartmentEntity>> call() async {
    return await repository.getAllDepartments();
  }
}