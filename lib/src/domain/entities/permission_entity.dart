import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';

class PermissionEntity {
  final String subjectId;
  final String plan;
  final bool isSuper; 
  final PermitTypes academy;
  final PermitTypes subject;

  PermissionEntity({
    required this.subjectId,
    required this.plan,
    required this.isSuper,
    required this.academy,
    required this.subject,
  });
}