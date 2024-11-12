import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentEntity {
  final String id;
  final String name;
  final String lastModificationDateTime;
  final String lastModificationContributor;
  final List<DocumentReference> academies;

  DepartmentEntity({
    String? id,
    required this.name,
    this.lastModificationDateTime = '',
    this.lastModificationContributor = '',
    this.academies = const [],
  }) : id = id ?? const Uuid().v4();

  DepartmentEntity.defaultValues()
      : id = 'default_id',
        name = 'default_name',
        lastModificationDateTime = DateTime.now().toString(),
        lastModificationContributor = '',
        academies = [];

  // Método fromMap para crear una instancia desde un mapa
  factory DepartmentEntity.fromMap(String id, Map<String, dynamic> data, FirebaseFirestore firestore) {
    return DepartmentEntity(
      id: id,
      name: data['name'] ?? '',
      lastModificationDateTime: data['lastModificationDateTime'] ?? '',
      lastModificationContributor: data['lastModificationContributor'] ?? '',
      academies: (data['academies'] as List<dynamic>?)
              ?.map((path) => firestore.doc(path as String))
              .toList() ??
          [],
    );
  }

  // Método toMap para convertir la entidad a un mapa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastModificationDateTime': lastModificationDateTime,
      'lastModificationContributor': lastModificationContributor,
      'academies': academies.map((academy) => academy.path).toList(),
    };
  }
}
