import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentEntity {
  String id;
  String name;
  String lastModificationDateTime;
  String lastModificationContributor; 

  DepartmentEntity({
    String? id,
    required this.name,
    this.lastModificationDateTime = '',
    this.lastModificationContributor = '', 
  }) : id = id ?? const Uuid().v4();

  DepartmentEntity.defaultValues()
      : id = 'default_id',
        name = 'default_name',
        lastModificationDateTime = DateTime.now().toString(),
        lastModificationContributor = '';

  // Método fromMap para crear una instancia desde un mapa
  factory DepartmentEntity.fromMap(String id, Map<String, dynamic> data, FirebaseFirestore firestore) {
    return DepartmentEntity(
      id: id,
      name: data['name'] ?? '',
      lastModificationDateTime: data['lastModificationDateTime'] ?? '',
      lastModificationContributor: data['lastModificationContributor'] ?? '', 
    );
  }

  // Método toMap para convertir la entidad a un mapa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastModificationDateTime': lastModificationDateTime,
      'lastModificationContributor': lastModificationContributor, 
    };
  }

  DepartmentEntity copyWith({
    String? id,
    String? name,
    String? lastModificationDateTime,
    String? lastModificationContributor,
  }) {
    return DepartmentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      lastModificationDateTime: lastModificationDateTime ?? this.lastModificationDateTime,
      lastModificationContributor: lastModificationContributor ?? this.lastModificationContributor,
    );
  }
}