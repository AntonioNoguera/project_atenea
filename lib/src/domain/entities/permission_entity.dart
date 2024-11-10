import 'package:proyect_atenea/src/domain/entities/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';

class PermissionEntity {
  final bool isSuper;
  final List<AtomicPermissionEntity> department;
  final List<AtomicPermissionEntity> academy;
  final List<AtomicPermissionEntity> subject;

  PermissionEntity({
    required this.isSuper,
    required this.department,
    required this.academy,
    required this.subject,
  });

  // Constructor nombrado con valores por defecto
  PermissionEntity.defaultValues()
      : isSuper = false,
        department = [],
        academy = [],
        subject = [];
}