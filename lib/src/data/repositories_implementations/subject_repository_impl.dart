// data/repositories/subject_repository_impl.dart 

import 'package:proyect_atenea/src/data/data_sources/subject_data_source.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/subject_repository.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  final SubjectDataSource dataSource;

  SubjectRepositoryImpl(this.dataSource);

  @override
  Future<SubjectEntity?> getSubjectById(String id) async {
    try {
      List<SubjectEntity> subjects = await dataSource.getSubjectsFromFirestore();
      
      // Buscar manualmente el elemento en la lista
      for (var subject in subjects) {
        if (subject.id == id) {
          return subject;
        }
      }
      
      // Si no se encuentra, devolver null
      return null;
    } catch (e) {
      print('Error obteniendo el subject: $e');
      return null;
    }
  }

  @override
  Future<void> addSubject(SubjectEntity subject) async {
    try {
      await dataSource.addSubjectOnFirestore(subject);
    } catch (e) {
      print('Error agregando el subject: $e');
    }
  }

  @override
  Future<void> updateSubject(SubjectEntity subject) async {
    try {
      await dataSource.updateSubjectOnFirestore(subject);
    } catch (e) {
      print('Error actualizando el subject: $e');
    }
  }

  @override
  Future<void> deleteSubject(String id) async {
    try {
      await dataSource.deleteSubjectFromFirestore(id);
    } catch (e) {
      print('Error eliminando el subject: $e');
    }
  }

  @override
  Future<List<SubjectEntity>> getAllSubjects() async {
    try {
      return await dataSource.getSubjectsFromFirestore();
    } catch (e) {
      print('Error obteniendo los subjects: $e');
      return [];
    }
  }
}
