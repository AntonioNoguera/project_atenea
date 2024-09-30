// lib/domain/repositories/session_repository.dart
import '../entities/session.dart';

abstract class SessionRepository {
  Future<Session?> getSession();
  Future<void> saveSession(Session session);
  Future<void> clearSession();
}
