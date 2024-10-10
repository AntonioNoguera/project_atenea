import 'package:proyect_atenea/src/domain/entities/academy_entity.dart'; 
import 'package:proyect_atenea/src/domain/entities/user_entity.dart';

abstract class AcademyRepository {
  Future<List<AcademyEntity?>> getAcademies();
  Future<void> addAcademy(AcademyEntity academyInstance);
  Future<void> updateAcademy(AcademyEntity academyInstance);
  Future<void> deleteAcademy(AcademyEntity academyInstance);
}