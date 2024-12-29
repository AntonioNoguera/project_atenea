import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/entities/shared/permission_entity.dart';
import 'package:proyect_atenea/src/domain/use_cases/session_use_cases.dart';

class SessionProvider with ChangeNotifier {
  final LoadSessionUseCase _loadSessionUseCase;
  final SaveSessionUseCase _saveSessionUseCase;
  final ClearSessionUseCase _clearSessionUseCase;
  final HasSessionUseCase _hasSessionUseCase;
  final UpdateSessionTokenUseCase _updateSessionTokenUseCase;
  final HasPermissionForUUIDUseCase _hasPermissionForUUIDUseCase;
  
  final UpdateSessionUseCase _updateSessionUseCase;
  

  SessionEntity? _session;

  SessionProvider({
    required LoadSessionUseCase loadSessionUseCase,
    required SaveSessionUseCase saveSessionUseCase,
    required ClearSessionUseCase clearSessionUseCase,
    required HasSessionUseCase hasSessionUseCase,
    required UpdateSessionTokenUseCase updateSessionTokenUseCase,
    required HasPermissionForUUIDUseCase hasPermissionForUUIDUseCase,
    required UpdateSessionUseCase updateSessionUseCase,
  })  : _loadSessionUseCase = loadSessionUseCase,
        _saveSessionUseCase = saveSessionUseCase,
        _clearSessionUseCase = clearSessionUseCase,
        _hasSessionUseCase = hasSessionUseCase,
        _updateSessionTokenUseCase = updateSessionTokenUseCase,
        _hasPermissionForUUIDUseCase = hasPermissionForUUIDUseCase,
        _updateSessionUseCase = updateSessionUseCase;

  // Verificar si hay sesión activa
  bool hasSession() {
    return _session != null &&
        _session!.tokenValidUntil.isAfter(DateTime.now());
  }

  // Cargar la sesión desde el almacenamiento
  Future<void> loadSession() async {
    _session = await _loadSessionUseCase.execute();
    notifyListeners();
  }

  // Actualizar campos específicos de la sesión usando UpdateSessionUseCase
  Future<void> updateSession({
    String? token,
    String? userId,
    String? userName,
    PermissionEntity? userPermissions,
    DateTime? tokenValidUntil,
    List? pinnedSubjects,
  }) async {
    try {
      // Llamamos al caso de uso para actualizar
      await _updateSessionUseCase.execute(
        token: token,
        userId: userId,
        userName: userName,
        userPermissions: userPermissions,
        tokenValidUntil: tokenValidUntil,
        pinnedSubjects: pinnedSubjects,
      );

      // Una vez que se ha actualizado la sesión, recargamos la sesión
      // para reflejar los cambios en _session
      _session = await _loadSessionUseCase.execute();

      // Notificamos a los listeners (Widgets) que algo ha cambiado
      notifyListeners();

    } catch (e) {
      print('Error al actualizar la sesión: $e');
    }
  }



  // Obtener la sesión actual
  Future<SessionEntity?> getSession() async {
    return await _loadSessionUseCase.execute();
  }

  // Guardar la sesión
  Future<void> saveSession(SessionEntity session) async {
    await _saveSessionUseCase.execute(session);
    _session = session;
    notifyListeners();
  }

  // Actualizar el token de sesión
  Future<void> updateSessionToken(String newToken) async {
    if (_session != null) {
      await _updateSessionTokenUseCase.execute(newToken);
      _session =
          await _loadSessionUseCase.execute(); // Recarga la sesión actualizada
      notifyListeners();
    }
  }

  // Limpiar la sesión
  Future<void> clearSession() async {
    await _clearSessionUseCase.execute();
    _session = null;
    notifyListeners();
  }

  SessionEntity? get currentSession => _session;

  // Verificar permisos para una entidad específica por UUID y nivel de entidad
  Future<List<PermitTypes>> hasPermissionForUUID(
      String uuid, String entityLevel) async {
    print(
        'Iniciando verificación de permisos para UUID: $uuid y nivel de entidad: $entityLevel');

    // Asegúrate de que la sesión esté cargada
    if (_session == null) {
      print('Sesión no encontrada, cargando sesión...');
      await loadSession();
    } else {
      print('Sesión ya cargada.');
    }

    // Imprime la sesión actual para verificar su estado
    print('Estado de la sesión actual:');
    print('Usuario ID: ${_session?.userId}');
    print('Usuario Nombre: ${_session?.userName}');
    print('Permisos del usuario: ${_session?.userPermissions}');
    print('Token válido hasta: ${_session?.tokenValidUntil}');

    // Ejecuta el caso de uso para verificar los permisos
    print('Ejecutando caso de uso hasPermissionForUUIDUseCase...');
    final permissions =
        await _hasPermissionForUUIDUseCase.execute(uuid, entityLevel);

    // Notifica a los listeners de cualquier cambio relevante en la UI
    notifyListeners();
    print(
        'Permisos obtenidos para UUID: $uuid, Nivel de entidad: $entityLevel -> $permissions');

    return permissions;
  }

  List<PermitTypes> getEntityPermission(String entityUUID, SystemEntitiesTypes entityType) {
  if (_session != null) {
    final PermissionEntity permissions = _session!.userPermissions;

    late List<AtomicPermissionEntity> specificPermissions;

    switch (entityType) {
      case SystemEntitiesTypes.department:
        specificPermissions = permissions.department;
        break; // Asegura que no continúe a los siguientes casos

      case SystemEntitiesTypes.academy: 
        specificPermissions = permissions.academy;
        break;

      case SystemEntitiesTypes.subject: 
        specificPermissions = permissions.subject;
        break;

      default:
        specificPermissions = []; // En caso de un tipo no esperado
    }

    return specificPermissions
      .where((perm) => perm.permissionId.path.contains(entityUUID)) // Filtra los permisos específicos
      .expand((perm) => perm.permissionTypes) // Aplana la lista de listas a una lista simple
      .toList(); 
  }
  

  return [];
}


Future<void> updatePinnedSubjects(String subjectId, bool remove) async {
  try {
    // 1. Cargamos la sesión actual si es null
    if (_session == null) {
      await loadSession(); // Esto llamará a _loadSessionUseCase.execute() internamente
    }

    // Si después de cargar sigue siendo null, no podemos actualizar nada
    if (_session == null) {
      print('No existe sesión para actualizar pinnedSubjects');
      return;
    }

    // 2. Obtenemos la lista actual de pinnedSubjects y la clonamos
    final currentPinned = List.of(_session!.pinnedSubjects);

    // 3. Dependiendo de si quieres agregar o remover
    if (remove) {
      // Filtramos la lista para quitar este subjectId
      currentPinned.removeWhere((ref) => ref == subjectId);
    } else { 
      if (!currentPinned.contains(subjectId)) {
        currentPinned.add(subjectId);
      } else {
        print('El subjectId "$subjectId" ya está en pinnedSubjects.');
      }
    }

    // 4. Mandamos llamar updateSession(...) con la nueva lista
    await updateSession(
      pinnedSubjects: currentPinned,
    );

    print('pinnedSubjects actualizado exitosamente');
  } catch (e) {
    print('Error al actualizar pinnedSubjects: $e');
  }
}

/// Helper para crear el DocumentReference (ajusta según tu estructura)
DocumentReference _makeSubjectDocRef(String subjectId) {
  // Ejemplo con Firestore:
  // import 'package:cloud_firestore/cloud_firestore.dart';
  return FirebaseFirestore.instance.doc('subjects/$subjectId');
}

}