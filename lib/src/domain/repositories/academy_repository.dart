import 'package:proyect_atenea/src/domain/entities/academy_entity.dart'; 

abstract class AcademyRepository {
  Future<void> addAcademy(AcademyEntity academy);
  Future<AcademyEntity?> getAcademyById(String id);
  Future<void> updateAcademy(AcademyEntity academy);
  Future<void> deleteAcademy(String id);
  Future<List<AcademyEntity>> getAllAcademies();
  Future<List<AcademyEntity>> getAcademiesByDepartmentId(String departmentId);
}