// domain/entities/plan_content_entity.dart

import 'package:proyect_atenea/src/domain/entities/content_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';

class PlanContentEntity {
  final PlanOption planNumber;
  final List<String> autorizedAdmins;
  final ContentEntity subjectThemes;
  final ContentEntity subjectFiles;

  PlanContentEntity({
    required this.planNumber,
    required this.autorizedAdmins,
    required this.subjectFiles,
    required this.subjectThemes,
  });

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'planNumber': planNumber.toString().split('.').last,
      'autorizedAdmins': autorizedAdmins,
      'subjectThemes': subjectThemes.toMap(),
      'subjectFiles': subjectFiles.toMap(),
    };
  }

  // Método para convertir desde Map
  factory PlanContentEntity.fromMap(Map<String, dynamic> data) {
    return PlanContentEntity(
      planNumber: PlanOption.values.firstWhere(
        (e) => e.toString() == 'PlanOption.${data['planNumber']}',
        orElse: () => PlanOption.none, // Ajusta según tu valor predeterminado
      ),
      autorizedAdmins: List<String>.from(data['autorizedAdmins'] ?? []),
      subjectThemes: ContentEntity.fromMap(data['subjectThemes'] as Map<String, dynamic>),
      subjectFiles: ContentEntity.fromMap(data['subjectFiles'] as Map<String, dynamic>),
    );
  }
}
