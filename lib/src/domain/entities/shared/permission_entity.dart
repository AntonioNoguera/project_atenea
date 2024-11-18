import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';

class PermissionEntity {
  final bool isSuper;
  List<AtomicPermissionEntity> department;
  List<AtomicPermissionEntity> academy;
  List<AtomicPermissionEntity> subject;

  PermissionEntity({
    required this.isSuper,
    required this.department,
    required this.academy,
    required this.subject,
  });

  // Constructor con valores por defecto
  PermissionEntity.defaultValues()
      : isSuper = false,
        department = [],
        academy = [],
        subject = [];

  // Método fromMap para convertir datos de Firestore a PermissionEntity
  factory PermissionEntity.fromMap(Map<String, dynamic> data) {
    return PermissionEntity(
      isSuper: data['isSuper'] ?? false,
      department: (data['department'] as List<dynamic>?)
              ?.map((perm) => AtomicPermissionEntity.fromMap(perm as Map<String, dynamic>))
              .toList() ??
          [],
      academy: (data['academy'] as List<dynamic>?)
              ?.map((perm) => AtomicPermissionEntity.fromMap(perm as Map<String, dynamic>))
              .toList() ??
          [],
      subject: (data['subject'] as List<dynamic>?)
              ?.map((perm) => AtomicPermissionEntity.fromMap(perm as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  // Método toMap para convertir PermissionEntity a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'isSuper': isSuper,
      'department': department.map((perm) => perm.toMap()).toList(),
      'academy': academy.map((perm) => perm.toMap()).toList(),
      'subject': subject.map((perm) => perm.toMap()).toList(),
    };
  }
}
