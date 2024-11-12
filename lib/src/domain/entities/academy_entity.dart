
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcademyEntity {
  final String id;
  final String name;
  final List<DocumentReference> subjects;
  final String lastModificationDateTime;
  final String lastModificationContributor;

  AcademyEntity({
    String? id,
    required this.name,
    this.subjects = const [],
    this.lastModificationDateTime = '',
    this.lastModificationContributor = '',
  }) : id = id ?? const Uuid().v4(); 

  // Método fromMap para convertir datos de Firestore a AcademyEntity
  factory AcademyEntity.fromMap(Map<String, dynamic> data, String documentId) {
    return AcademyEntity(
      id: documentId,
      name: data['name'] ?? '',
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
      'subjects': subjects,
      'lastModificationDateTime': lastModificationDateTime,
      'lastModificationContributor': lastModificationContributor,
    };
  }
}