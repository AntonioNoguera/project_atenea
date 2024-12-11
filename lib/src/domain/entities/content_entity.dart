// domain/entities/content_entity.dart

import 'package:proyect_atenea/src/domain/entities/file_entity.dart';

class ContentEntity {
  final List<String> halfTerm;
  final List<String> ordinary;

  ContentEntity({
    required this.halfTerm,
    required this.ordinary,
  });

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'halfTerm': halfTerm,
      'ordinary': ordinary,
    };
  }

  // Método para convertir desde Map
  factory ContentEntity.fromMap(Map<String, dynamic> data) {
    return ContentEntity(
      halfTerm: List<String>.from(data['halfTerm'] ?? []),
      ordinary: List<String>.from(data['ordinary'] ?? []),
    );
  }
}
