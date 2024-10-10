 

import 'package:proyect_atenea/src/data/data_sources/academy_data_source.dart';
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/academy_repository.dart';

class AcademyRepositoryImpl implements AcademyRepository {
  final AcademyDataSource dataSource;

  AcademyRepositoryImpl(this.dataSource);
 

  @override
  Future<void> deleteAcademy(AcademyEntity academyInstance) async {
    await dataSource.deleteAcademyFromFirestore(academyInstance);
  }
 

  @override
  Future<void> updateAcademy(AcademyEntity academyInstance) async {
    await dataSource.updateAcademyOnFirestore(academyInstance);
  }
  
  @override
  Future<List<AcademyEntity?>> getAcademies() async { 
    return await dataSource.getAcademiesFromFirestore(); 
  }
  
  @override
  Future<void> addAcademy(AcademyEntity academyInstance) async {
    await dataSource.addAcademyOnFirestore(academyInstance);
  }
 
}
