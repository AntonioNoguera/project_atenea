import '../../domain/entities/session.dart';
import '../../domain/repositories/SessionRepository.dart';
import '../datasources/SessionManagerDataSource.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionLocalDataSource localDataSource;

  SessionRepositoryImpl(this.localDataSource);

  @override
  Future<Session?> getSession() async {
    final token = await localDataSource.getToken();
    if (token != null) {
      return Session(token: token);
    }
    return null;
  }

  @override
  Future<void> saveSession(Session session) async {
    await localDataSource.saveToken(session.token);
  }

  @override
  Future<void> clearSession() async {
    await localDataSource.clearToken();
  }
}