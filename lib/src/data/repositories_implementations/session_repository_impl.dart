import 'package:proyect_atenea/src/data/data_sources/local_session_data_source.dart';
import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final LocalSessionDataSource localDataSource;

  SessionRepositoryImpl(this.localDataSource);

  @override
  Future<SessionEntity?> getSession() async {
    final session = await localDataSource.getSession();

    if (session != null) {
      return session; 
    }
    return null;
  }
  
  @override
  Future<void> clearSession() async {
    await localDataSource.removeSession();
  }
  
  @override
  Future<void> saveSession(SessionEntity session) async {  
    await localDataSource.addSession(session);
  }
} 
