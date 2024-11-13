// domain/entities/plan_content_entity.dart

import 'package:proyect_atenea/src/domain/entities/content_entity.dart'; 

class PlanContentEntity {  
  final ContentEntity subjectThemes;
  final ContentEntity subjectFiles;

  PlanContentEntity({ 
    required this.subjectFiles,
    required this.subjectThemes,
  });

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return { 
      'subjectThemes': subjectThemes.toMap(),
      'subjectFiles': subjectFiles.toMap(),
    };
  }

  // Método para convertir desde Map
  factory PlanContentEntity.fromMap(Map<String, dynamic> data) {
    return PlanContentEntity( 
      subjectThemes: ContentEntity.fromMap(data['subjectThemes'] as Map<String, dynamic>),
      subjectFiles: ContentEntity.fromMap(data['subjectFiles'] as Map<String, dynamic>),
    );
  }
}
