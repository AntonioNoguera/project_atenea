import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/subject_entity.dart';
import 'package:proyect_atenea/src/domain/use_cases/subject_use_case.dart'; 

class SubjectProvider with ChangeNotifier {
  final GetSubjectById getSubjectByIdUseCase;
  final AddSubject addSubjectUseCase;
  final UpdateSubject updateSubjectUseCase;
  final DeleteSubject deleteSubjectUseCase;
  final GetAllSubjects getAllSubjectsUseCase;
  final GetSubjectsByAcademyID getSubjectsByAcademyIdUseCase;

  SubjectProvider({
    required this.getSubjectByIdUseCase,
    required this.addSubjectUseCase,
    required this.updateSubjectUseCase,
    required this.deleteSubjectUseCase,
    required this.getAllSubjectsUseCase,
    required this.getSubjectsByAcademyIdUseCase,
  });

  Future<SubjectEntity?> getSubject(String id) async {
    print('Obteniendo materia con ID: $id');
    final subject = await getSubjectByIdUseCase(id);
    print('Materia obtenida: ${subject.toString()}');
    return subject;
  }

  Future<void> addSubject(SubjectEntity subject) async {
    print('Guardando nueva materia: $subject');
    await addSubjectUseCase(subject);
    print('Materia guardada');
    notifyListeners();
  }

  Future<void> updateSubject(SubjectEntity subject) async {
    print('Actualizando materia: $subject');
    await updateSubjectUseCase(subject);
    print('Materia actualizada');
    notifyListeners();
  }

  Future<void> deleteSubject(String id) async {
    print('Eliminando materia con ID: $id');
    await deleteSubjectUseCase(id);
    print('Materia eliminada');
    notifyListeners();
  }

  Future<List<SubjectEntity>> getAllSubjects() async {
    print('Obteniendo todas las materias');
    final subjects = await getAllSubjectsUseCase();
    print('Materias obtenidas: $subjects');
    return subjects;
  }

  Future<List<SubjectEntity>> getSubjectsByAcademyID(String academyId) async {
    print('Obteniendo materias para la academia con ID: $academyId');
    final subjects = await getSubjectsByAcademyIdUseCase(academyId);
    print('Materias obtenidas: ${subjects.map((s) => s.name).toList()}');
    return subjects;
  }


}
