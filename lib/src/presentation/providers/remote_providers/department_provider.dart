import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/department_entity.dart';
import 'package:proyect_atenea/src/domain/use_cases/department_use_case.dart'; 

class DepartmentProvider with ChangeNotifier {
  final GetDepartmentUseCase getDepartmentUseCase;
  final SaveDepartmentUseCase saveDepartmentUseCase;
  final UpdateDepartmentUseCase updateDepartmentUseCase; 
  final DeleteDepartmentUseCase deleteDepartmentUseCase;
  final GetAllDepartmentsUseCase getAllDepartmentsUseCase;

  DepartmentProvider({
    required this.getDepartmentUseCase,
    required this.saveDepartmentUseCase,
    required this.updateDepartmentUseCase,
    required this.deleteDepartmentUseCase,
    required this.getAllDepartmentsUseCase,
  });

  Future<DepartmentEntity?> getDepartment(String id) async {
    print('Obteniendo departamento con ID: $id');
    final department = await getDepartmentUseCase(id);
    print('Departamento obtenido: ${department.toString()}');
    return department;
  }

  Future<void> saveDepartment(DepartmentEntity department) async {
    print('Guardando departamento: $department');
    await saveDepartmentUseCase(department);
    print('Departamento guardado');
    notifyListeners();
  }

  Future<void> updateDepartment(DepartmentEntity department) async {
    print('Actualizando departamento: $department');
    await updateDepartmentUseCase(department); // Llama al caso de uso de actualización
    print('Departamento actualizado');
    notifyListeners();
  }

  Future<void> deleteDepartment(String id) async {
    print('Eliminando departamento con ID: $id');
    await deleteDepartmentUseCase(id);
    print('Departamento eliminado');
    notifyListeners();
  }

  Future<List<DepartmentEntity>> getAllDepartments() async {
    print('Obteniendo todos los departamentos');
    final departments = await getAllDepartmentsUseCase();
    print('Departamentos obtenidos: $departments');
    return departments;
  }
}