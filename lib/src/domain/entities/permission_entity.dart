import 'package:proyect_atenea/src/domain/entities/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/enum_fixed_values.dart';

class PermissionEntity {  
  final bool isSuper;
  final List<AtomicPermissionEntity> academy;
  final List<AtomicPermissionEntity> subject;

  PermissionEntity({ 
    required this.isSuper,
    required this.academy,
    required this.subject,
  });
}