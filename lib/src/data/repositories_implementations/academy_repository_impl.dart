// data/repositories/academy_repository_impl.dart
 
import 'package:proyect_atenea/src/data/data_sources/academy_data_source.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/academy_repository.dart';

class AcademyRepositoryImpl implements AcademyRepository {
  final AcademyDataSource dataSource;

  AcademyRepositoryImpl(this.dataSource);

  @override
  Future<AcademyEntity?> getAcademyById(String id) async {
    try {
      List<AcademyEntity> academies = await dataSource.getAcademiesFromFirestore();
      
      // Utilizar firstWhere y capturar la excepción si no se encuentra el elemento
      return academies.firstWhere((academy) => academy.id == id);
    } catch (e) {
      if (e is StateError) {
        // StateError se lanza cuando no se encuentra el elemento en firstWhere
        return null;
      }
      print('Error obteniendo la academia: $e');
      return null;
    }
  } 


  @override
  Future<void> addAcademy(AcademyEntity academy) async {
    try {
      await dataSource.addAcademyOnFirestore(academy);
    } catch (e) {
      print('Error guardando la academia: $e');
    }
  }

  @override
  Future<void> deleteAcademy(String id) async {
    try {
      await dataSource.deleteAcademyFromFirestore(id);
    } catch (e) {
      print('Error eliminando la academia: $e');
    }
  }

  @override
  Future<List<AcademyEntity>> getAllAcademies() async {
    try {
      return await dataSource.getAcademiesFromFirestore();
    } catch (e) {
      print('Error obteniendo las academias: $e');
      return [];
    }
  }

  @override
  Future<void> updateAcademy(AcademyEntity academy) async {
    try {
      await dataSource.updateAcademyOnFirestore(academy);
    } catch (e) {
      print('Error actualizando la academia: $e');
    }
  }

  @override
  Future<List<AcademyEntity>> getAcademiesByDepartmentId(String departmentId) async {
    return await dataSource.getAcademiesByDepartmentId(departmentId);
  }
}
