// domain/use_cases/user_use_cases.dart
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/academy_repository.dart';

class GetAcademies {
  final AcademyRepository repository;

  GetAcademies(this.repository);
  
  Future<List<AcademyEntity?>> call() async {
    return await repository.getAcademies();
  }
}

class AddAcademy {
  final AcademyRepository repository;

  AddAcademy(this.repository);

  Future<void> call(AcademyEntity academy) async {
    await repository.addAcademy(academy);
  }
}
 
class UpdateAcademy {
  final AcademyRepository repository;

  UpdateAcademy(this.repository);

  Future<void> call(AcademyEntity academy) async {
    await repository.updateAcademy(academy);
  }
}

class DeleteAcademy {
  final AcademyRepository repository;

  DeleteAcademy(this.repository);

  Future<void> call(AcademyEntity academy) async {
    await repository.deleteAcademy(academy);
  }
}
