import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';

class AcademyEntity {
  final String id;
  final AcademyDepartments parentDepartment;
  final List<String> autorizedAdmins; 

  AcademyEntity({
    required this.id,
    required this.parentDepartment,
    required this.autorizedAdmins,
  });
}

 