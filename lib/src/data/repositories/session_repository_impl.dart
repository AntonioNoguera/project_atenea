import 'package:proyect_atenea/src/data/data_sources/session_manager_data_source.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionLocalDataSource localDataSource;

  const SessionRepositoryImpl(this.localDataSource);

  @override
  Future<SessionEntity?> getSession() async {
    final token = await localDataSource.getToken();

    if (token != null) {
      //return SessionEntity(token: token);
    }
    return null;
  }

  @override
  Future<void> saveSession(SessionEntity session) async {
    await localDataSource.saveToken(session.token);
  }

  @override
  Future<void> clearSession() async {
    await localDataSource.clearToken();
  }
}
