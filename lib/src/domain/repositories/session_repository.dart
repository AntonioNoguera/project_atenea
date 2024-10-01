import '../entities/session.dart';

abstract class SessionRepository {
  const SessionRepository();

  Future<Session?> getSession();
  Future<void> saveSession(Session session);
  Future<void> clearSession();
}
