import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';
import 'package:proyect_atenea/src/domain/use_cases/session_use_cases.dart';

class SessionProvider with ChangeNotifier {
  final GetSessionUseCase _getSessionUseCase;
  final SaveSessionUseCase _saveSessionUseCase;
  final ClearSessionUseCase _clearSessionUseCase;

  SessionEntity? _session;

  SessionProvider({
    required GetSessionUseCase getSessionUseCase,
    required SaveSessionUseCase saveSessionUseCase,
    required ClearSessionUseCase clearSessionUseCase,
  })  : _getSessionUseCase = getSessionUseCase,
        _saveSessionUseCase = saveSessionUseCase,
        _clearSessionUseCase = clearSessionUseCase;

  bool hasSession() {
    return _session != null;
  }

  Future<void> loadSession() async {
    _session = await _getSessionUseCase();
    notifyListeners();
  }

  Future<SessionEntity?> getSession() async {
    return await _getSessionUseCase();
  }

  Future<void> saveSession(String token) async {
    
    /*
    final session = SessionEntity(token: token);


    await _saveSessionUseCase(session);
    _session = session;
    notifyListeners();*/
  }

  Future<void> clearSession() async {
    await _clearSessionUseCase();
    _session = null;
    notifyListeners();
  }

  Future<List<PermitTypes>> hasPermissionForUUID(
    String uuid, 
    String entityLevel
    ) async {

    // Asegúrate de que la sesión esté cargada
    if (_session == null) {
      print('Cargando la sesión porque aún no está cargada.');
      await loadSession();
    } else {
      print('Sesión ya cargada.');
    }

    // Verifica si es superusuario
    if (_session?.userPermissions.isSuper == true) {
      print('El usuario es superusuario, tiene permiso para todas las entidades.');
      return PermitTypes.values.toList(); // Devuelve todos los permisos si es superusuario
    }

    // Selecciona la lista de permisos adecuada según el nivel de entidad
    List<AtomicPermissionEntity> permissions;
    print('Nivel de entidad solicitado: $entityLevel');

    switch (entityLevel.toLowerCase()) {
      case 'departments':
        permissions = _session!.userPermissions.department;
        print('Seleccionado nivel de permisos: Departments');
        break;
        
      case 'academies':
        permissions = _session!.userPermissions.academy;
        print('Seleccionado nivel de permisos: Academies');
        break;
        
      case 'subjects':
        permissions = _session!.userPermissions.subject;
        print('Seleccionado nivel de permisos: Subjects');
        break;
        
      default:
        print('Nivel de entidad no válido: $entityLevel');
        return []; // Devuelve una lista vacía si el nivel de entidad es inválido
    }

    // Verifica si algún permiso en la lista coincide con el UUID y retorna los tipos de permiso
    final pathToCheck = '$entityLevel/$uuid';
    print('Verificando permisos para path: $pathToCheck');
    
    // Filtra para encontrar permisos coincidentes y extrae los tipos de permisos si los encuentra
    final matchingPermissions = permissions.where((perm) => perm.permissionId.path == pathToCheck).toList();

    if (matchingPermissions.isNotEmpty) {
      print('Permiso encontrado para $pathToCheck con los permisos: ${matchingPermissions.first.permissionTypes}.');
      return matchingPermissions.first.permissionTypes;
    } else {
      print('Permiso no encontrado para $pathToCheck.');
      // Retorna una lista vacía si no se encontró el permiso
      return [];
    }
  }

}
