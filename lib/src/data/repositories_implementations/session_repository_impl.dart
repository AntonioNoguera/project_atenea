import 'package:proyect_atenea/src/data/data_sources/session_local_data_source.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/session_repository.dart'; 

class SessionRepositoryImpl implements SessionRepository {
  final SessionLocalDataSource localDataSource;

  SessionRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveSession(SessionEntity session) async {
    await localDataSource.saveSession(session);
  }

  @override
  Future<SessionEntity?> loadSession() async {
    return await localDataSource.loadSession();
  }

  @override
  Future<void> clearSession() async {
    await localDataSource.clearSession();
  }
}
