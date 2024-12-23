// domain/repositories/subject_repository.dart

import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';

abstract class SubjectRepository {
  Future<SubjectEntity?> getSubjectById(String id);
  Future<void> addSubject(SubjectEntity subject);
  Future<void> updateSubject(SubjectEntity subject);
  Future<void> deleteSubject(String id);
  Future<List<SubjectEntity>> getAllSubjects();
  Future<List<SubjectEntity>> getSubjectsByAcademyID(String academyId);
}
