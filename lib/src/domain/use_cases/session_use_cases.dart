import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/atomic_permission_entity.dart';
import 'package:proyect_atenea/src/domain/entities/shared/enum_fixed_values.dart';
import 'package:proyect_atenea/src/domain/repositories/session_repository.dart';

// Caso de uso para cargar la sesión
class LoadSessionUseCase {
  final SessionRepository _repository;

  LoadSessionUseCase(this._repository);

  Future<SessionEntity?> execute() async {
    
    try {
      var session = await _repository.loadSession();

      if (session != null) {
        // Imprime la sesión actual para verificar su estado
          print('---- leyendo session almacenada ----');
          print('Usuario ID: ${session.userId}');
          print('Usuario Nombre: ${session.userName}'); 
          print('Token válido hasta: ${session.tokenValidUntil}');
      } else {
        print('No se encontró una sesión almacenada.');
      }

      
          return session;

    } catch (e) {
      print("Error loading session: $e");
      return null;
    }
  }
}

// Caso de uso para guardar la sesión
class SaveSessionUseCase {
  final SessionRepository _repository;

  SaveSessionUseCase(this._repository);

  Future<void> execute(SessionEntity session) async {
    try {
      await _repository.saveSession(session);

            // Imprime la sesión actual para verificar su estado
          print('---- session almacenada ----');
          print('Usuario ID: ${session.userId}');
          print('Usuario Nombre: ${session.userName}'); 
          print('Token válido hasta: ${session.tokenValidUntil}');

    } catch (e) {
      print("Error saving session: $e");
    }
  }
}

// Caso de uso para limpiar la sesión
class ClearSessionUseCase {
  final SessionRepository _repository;

  ClearSessionUseCase(this._repository);

  Future<void> execute() async {
    try {
      await _repository.clearSession();
    } catch (e) {
      print("Error clearing session: $e");
    }
  }
}

// Caso de uso para verificar si hay una sesión activa
class HasSessionUseCase {
  final LoadSessionUseCase _loadSessionUseCase;

  HasSessionUseCase(this._loadSessionUseCase);

  Future<bool> execute() async {
    final session = await _loadSessionUseCase.execute();
    return session != null && session.tokenValidUntil.isAfter(DateTime.now());
  }
}

// Caso de uso para actualizar el token de sesión
class UpdateSessionTokenUseCase {
  final SaveSessionUseCase _saveSessionUseCase;
  final LoadSessionUseCase _loadSessionUseCase;

  UpdateSessionTokenUseCase(this._saveSessionUseCase, this._loadSessionUseCase);

  Future<void> execute(String newToken) async {
    final currentSession = await _loadSessionUseCase.execute();
    if (currentSession != null) {
      final updatedSession = SessionEntity(
        token: newToken,
        userId: currentSession.userId,
        userName: currentSession.userName,
        savedSubjects: currentSession.savedSubjects,
        tokenValidUntil: currentSession.tokenValidUntil,
      );
      await _saveSessionUseCase.execute(updatedSession);
    }
  }
}