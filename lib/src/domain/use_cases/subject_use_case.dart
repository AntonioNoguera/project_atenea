// domain/use_cases/subject_use_cases.dart

import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/subject_repository.dart';

/// Caso de uso para obtener una materia por ID
class GetSubjectById {
  final SubjectRepository repository;

  GetSubjectById(this.repository);

  Future<SubjectEntity?> call(String id) async {
    return await repository.getSubjectById(id);
  }
}

/// Caso de uso para agregar una nueva materia
class AddSubject {
  final SubjectRepository repository;

  AddSubject(this.repository);

  Future<void> call(SubjectEntity subject) async {
    await repository.addSubject(subject);
  }
}

/// Caso de uso para actualizar una materia existente
class UpdateSubject {
  final SubjectRepository repository;

  UpdateSubject(this.repository);

  Future<void> call(SubjectEntity subject) async {
    await repository.updateSubject(subject);
  }
}

/// Caso de uso para eliminar una materia por ID
class DeleteSubject {
  final SubjectRepository repository;

  DeleteSubject(this.repository);

  Future<void> call(String id) async {
    await repository.deleteSubject(id);
  }
}

/// Caso de uso para obtener todas las materias
class GetAllSubjects {
  final SubjectRepository repository;

  GetAllSubjects(this.repository);

  Future<List<SubjectEntity>> call() async {
    return await repository.getAllSubjects();
  }
}

class GetSubjectsByAcademyID {
  final SubjectRepository repository;

  GetSubjectsByAcademyID(this.repository);

  Future<List<SubjectEntity>> call(String academyId) async {
    return await repository.getSubjectsByAcademyID(academyId);
  }
}
