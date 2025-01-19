import 'package:uuid/uuid.dart';

class FileEntity {
  String id;
  String name;
  String extension;
  int size;
  String downloadUrl;
  String subjectId;
  String uploadedAt;
  List<int>? fileBytes;

  FileEntity({
    String? id,
    required this.name,
    required this.extension,
    required this.size,
    required this.downloadUrl,
    required this.subjectId,
    required this.uploadedAt,
    List<int>? this.fileBytes 
  }) : id = id ?? const Uuid().v4();

  // Propiedad estática para los valores predeterminados
  static final FileEntity defaultValue = FileEntity(
    name: 'Untitled',
    extension: 'txt',
    size: 0,
    downloadUrl: '',
    subjectId: '',
    uploadedAt: '',
  );

  // Método copyWith
  FileEntity copyWith({
    String? id,
    String? name,
    String? extension,
    int? size,
    String? downloadUrl,
    String? subjectId,
    String? uploadedAt,
    List<int>? fileBytes,
  }) {
    return FileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      extension: extension ?? this.extension,
      size: size ?? this.size,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      subjectId: subjectId ?? this.subjectId,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      fileBytes: fileBytes ?? this.fileBytes,
    );
  }

  // Convertir Firestore snapshot a FileEntity
  factory FileEntity.fromMap(Map<String, dynamic> map, String id) {
    try {
      return FileEntity(
        id: id ?? '',
        name: map['name'] ?? '',
        extension: map['type'] ?? '',
        size: map['size'] ?? 0,
        downloadUrl: map['downloadUrl'] ?? '',
        subjectId: map['subjectId'] ?? '',
        uploadedAt: map['uploadedAt'] ?? '',
      );
    } catch (e, stacktrace) {
      // Log de errores en caso de fallo
      print('[FileEntity.fromMap] Error al crear FileEntity: $e');
      print('[FileEntity.fromMap] Stacktrace: $stacktrace');
      rethrow; // Lanza de nuevo el error para no perder contexto
    }
  }

  // Convertir FileEntity a Map para guardarlo en Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': extension,
      'size': size,
      'downloadUrl': downloadUrl,
      'subjectId': subjectId,
      'uploadedAt': uploadedAt,
    };
  }
}
