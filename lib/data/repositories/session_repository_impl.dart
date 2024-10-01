import 'package:proyect_atenea/data/datasources/session_manager_data_source.dart';
import 'package:proyect_atenea/domain/entities/session.dart';
import 'package:proyect_atenea/domain/repositories/session_repository.dart';

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
