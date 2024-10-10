import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/files_entity.dart';
import 'package:proyect_atenea/src/domain/entities/themes_entity.dart';

class PlanEntity {
  final PlanOptions planNumber;
  final List<String> autorizedAdmins;
  final ThemesEntity subjectThemes;
  final FilesEntity subjectFiles ;
  
  PlanEntity({
    required this.planNumber,
    required this.autorizedAdmins,
    required this.subjectFiles,
    required this.subjectThemes,
  });
}
