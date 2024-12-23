import 'package:flutter/material.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/use_cases/session_use_cases.dart';

class SessionProvider with ChangeNotifier {
  final LoadSessionUseCase _loadSessionUseCase;
  final SaveSessionUseCase _saveSessionUseCase;
  final ClearSessionUseCase _clearSessionUseCase;
  final HasSessionUseCase _hasSessionUseCase;
  final UpdateSessionTokenUseCase _updateSessionTokenUseCase; 

  SessionEntity? _session;

  SessionProvider({
    required LoadSessionUseCase loadSessionUseCase,
    required SaveSessionUseCase saveSessionUseCase,
    required ClearSessionUseCase clearSessionUseCase,
    required HasSessionUseCase hasSessionUseCase,
    required UpdateSessionTokenUseCase updateSessionTokenUseCase, 
  })  : _loadSessionUseCase = loadSessionUseCase,
        _saveSessionUseCase = saveSessionUseCase,
        _clearSessionUseCase = clearSessionUseCase,
        _hasSessionUseCase = hasSessionUseCase,
        _updateSessionTokenUseCase = updateSessionTokenUseCase;

  // Verificar si hay sesión activa
  bool hasSession() {
    return _session != null && _session!.tokenValidUntil.isAfter(DateTime.now());
  }

  // Cargar la sesión desde el almacenamiento
  Future<void> loadSession() async {
      _session = await _loadSessionUseCase.execute();
      notifyListeners();
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
        _session = await _loadSessionUseCase.execute(); // Recarga la sesión actualizada
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
}
