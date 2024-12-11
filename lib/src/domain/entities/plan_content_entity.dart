import 'package:proyect_atenea/src/domain/entities/content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/file_entity.dart';

class PlanContentEntity {
  final ContentEntity subjectThemes;
  final List<FileEntity>? subjectFiles;

  PlanContentEntity({
    required this.subjectThemes,
    this.subjectFiles, // Ahora es nulleable
  });

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'subjectThemes': subjectThemes.toMap(),
      'subjectFiles': subjectFiles?.map((file) => file.toMap()).toList(),
    };
  }

  // Método para convertir desde Map
  factory PlanContentEntity.fromMap(Map<String, dynamic> data) {
    return PlanContentEntity(
      subjectThemes: ContentEntity.fromMap(data['subjectThemes'] as Map<String, dynamic>),
      subjectFiles: data['subjectFiles'] != null
          ? (data['subjectFiles'] as List<dynamic>)
              .map((file) => FileEntity.fromMap(file as Map<String, dynamic>, file['id']))
              .toList()
          : null, // Manejo de nulo
    );
  }
}
