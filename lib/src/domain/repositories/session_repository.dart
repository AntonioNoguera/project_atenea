import 'package:proyect_atenea/src/domain/entities/session_entity.dart';

abstract class SessionRepository {
  Future<void> saveSession(SessionEntity session);
  Future<SessionEntity?> loadSession();
  Future<void> clearSession();
}
