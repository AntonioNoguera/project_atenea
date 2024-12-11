import 'package:uuid/uuid.dart';

class FileEntity {
  String id;
  String name;
  String extension;
  int size; 
  String downloadUrl;
  String subjectId;
  String uploadedAt;

  FileEntity({
    String? id,
    required this.name,
    required this.extension,
    required this.size,
    required this.downloadUrl,
    required this.subjectId,
    required this.uploadedAt,
  }) : id = id ?? const Uuid().v4();

  // Convertir Firestore snapshot a FileEntity
  factory FileEntity.fromMap(Map<String, dynamic> map, String id) {
    return FileEntity( 
      id: id ?? '',
      name: map['name'] ?? '',
      extension: map['type'] ?? '',
      size: map['size'] ?? 0,
      downloadUrl: map['downloadUrl'] ?? '',
      subjectId: map['subjectId'] ?? '',
      uploadedAt: map['uploadedAt'] ?? '',
    );
  }

  // Convertir FileEntity a Map para guardarlo en Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': extension,
      'size': size,
      'downloadUrl': downloadUrl,
      'subjectId': subjectId,
      'uploadedAt': uploadedAt,
    };
  }
}