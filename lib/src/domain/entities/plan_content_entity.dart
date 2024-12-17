import 'dart:collection'; // Importar para usar HashMap
import 'package:proyect_atenea/src/domain/entities/content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/file_entity.dart';

class PlanContentEntity {
  ContentEntity subjectThemes;
  HashMap<int, FileEntity>? subjectFiles;

  PlanContentEntity({
    required this.subjectThemes,
    this.subjectFiles,
  });

  Map<String, dynamic> toMap() {
    return {
      'subjectThemes': subjectThemes.toMap(),
      'subjectFiles': subjectFiles?.map((key, file) => MapEntry(key.toString(), file.toMap())),
    };
  }

  factory PlanContentEntity.fromMap(Map<String, dynamic> data) {
    return PlanContentEntity(
      subjectThemes: ContentEntity.fromMap(data['subjectThemes'] as Map<String, dynamic>),
      subjectFiles: data['subjectFiles'] != null
          ? HashMap<int, FileEntity>.from(
              (data['subjectFiles'] as Map<String, dynamic>).map(
                (key, file) => MapEntry(int.parse(key), FileEntity.fromMap(file as Map<String, dynamic>, file['id'])),
              ),
            )
          : null,
    );
  }
}