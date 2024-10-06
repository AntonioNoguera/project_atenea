import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:proyect_atenea/src/domain/repositories/session_repository.dart';

class GetSessionUseCase {
  final SessionRepository repository;

  const GetSessionUseCase(this.repository);

  Future<SessionEntity?> call() async {
    return await repository.getSession();
  }
}

class SaveSessionUseCase {
  final SessionRepository repository;

  const SaveSessionUseCase(this.repository);

  Future<void> call(SessionEntity session) async {
    await repository.saveSession(session);
  }
}

class ClearSessionUseCase {
  final SessionRepository repository;

  const ClearSessionUseCase(this.repository);

  Future<void> call() async {
    await repository.clearSession();
  }
}
