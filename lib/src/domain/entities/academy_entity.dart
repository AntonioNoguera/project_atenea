import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcademyEntity {
  final String id;
  final String name;
  final DocumentReference parentDepartment;
  final List<DocumentReference> subjects;
  final String lastModificationDateTime;
  final String lastModificationContributor;

  AcademyEntity({
    String? id,
    required this.name,
    required this.parentDepartment,
    this.subjects = const [],
    String? lastModificationDateTime,
    this.lastModificationContributor = '',
  }) : id = id ?? const Uuid().v4(),
      lastModificationDateTime = lastModificationDateTime ?? DateTime.now().toString()
  ;

  // Método fromMap para convertir datos de Firestore a AcademyEntity
  factory AcademyEntity.fromMap(Map<String, dynamic> data, String documentId, FirebaseFirestore firestore) {
    return AcademyEntity(
      id: documentId,
      name: data['name'] ?? '',
      parentDepartment: firestore.doc(data['parentDepartment'] as String),
      subjects: (data['subjects'] as List<dynamic>?)
              ?.map((subject) => subject as DocumentReference)
              .toList() ??
          [],
      lastModificationDateTime: data['lastModificationDateTime'] ?? '',
      lastModificationContributor: data['lastModificationContributor'] ?? '',
    );
  }

  // Método toMap para convertir AcademyEntity a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'parentDepartment': parentDepartment.path,
      'subjects': subjects.map((subject) => subject.path).toList(),
      'lastModificationDateTime': lastModificationDateTime,
      'lastModificationContributor': lastModificationContributor,
    };
  }
}
