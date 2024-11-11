// domain/use_cases/academy_use_cases.dart
import 'package:proyect_atenea/src/domain/entities/academy_entity.dart';

import '../repositories/academy_repository.dart'; 

/// Caso de uso para obtener una academia por ID
class GetAcademyById {
  final AcademyRepository repository;

  GetAcademyById(this.repository);

  Future<AcademyEntity?> call(String id) async {
    return await repository.getAcademyById(id);
  }
}

/// Caso de uso para agregar una nueva academia
class AddAcademy {
  final AcademyRepository repository;

  AddAcademy(this.repository);

  Future<void> call(AcademyEntity academy) async {
    await repository.addAcademy(academy);
  }
}

/// Caso de uso para actualizar una academia existente
class UpdateAcademy {
  final AcademyRepository repository;

  UpdateAcademy(this.repository);

  Future<void> call(AcademyEntity academy) async {
    await repository.updateAcademy(academy);
  }
}

/// Caso de uso para eliminar una academia por ID
class DeleteAcademy {
  final AcademyRepository repository;

  DeleteAcademy(this.repository);

  Future<void> call(String id) async {
    await repository.deleteAcademy(id);
  }
}

/// Caso de uso para obtener todas las academias
class GetAllAcademies {
  final AcademyRepository repository;

  GetAllAcademies(this.repository);

  Future<List<AcademyEntity>> call() async {
    return await repository.getAllAcademies();
  }
}
