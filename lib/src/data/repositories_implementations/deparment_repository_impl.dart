import 'package:proyect_atenea/src/data/data_sources/deparment_data_source.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart'; 
import 'package:proyect_atenea/src/domain/repositories/department_repository.dart'; 

class DepartmentRepositoryImpl implements DepartmentRepository {
  final DepartmentDataSource dataSource;

  DepartmentRepositoryImpl(this.dataSource);

  @override
  Future<DepartmentEntity?> getDepartment(String id) async {
    try {
      List<DepartmentEntity> departments = await dataSource.getDepartmentsFromFirestore();
      return departments.firstWhere((department) => department.id == id);
    } catch (e) {
      // Si no se encuentra el departamento o ocurre algún otro error
      print('Error obteniendo el departamento: $e');
      return null;
    }
  }

  @override
  Future<void> saveDepartment(DepartmentEntity department) async {
    try {
      await dataSource.addDepartmentOnFirestore(department);
    } catch (e) {
      print('Error guardando el departamento: $e');
    }
  }

  @override
  Future<void> updateDepartment(DepartmentEntity department) async {
    try {
      await dataSource.updateDepartmentOnFirestore(department);
    } catch (e) {
      print('Error actualizando el departamento: $e');
    }
  }

  @override
  Future<void> deleteDepartment(String id) async {
    try {
      await dataSource.deleteDepartmentFromFirestore(id);
    } catch (e) {
      print('Error eliminando el departamento: $e');
    }
  }

  @override
  Future<List<DepartmentEntity>> getAllDepartments() async {
    try {
      return await dataSource.getDepartmentsFromFirestore();
    } catch (e) {
      print('Error obteniendo los departamentos: $e');
      return [];
    }
  }
}
