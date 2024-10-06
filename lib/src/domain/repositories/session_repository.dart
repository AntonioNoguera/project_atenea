import '../entities/session_entity.dart';

abstract class SessionRepository {
  const SessionRepository();

  Future<SessionEntity?> getSession();
  Future<void> saveSession(SessionEntity session);
  Future<void> clearSession();
}
