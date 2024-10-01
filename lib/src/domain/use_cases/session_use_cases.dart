import 'package:proyect_atenea/src/domain/entities/session.dart';
import 'package:proyect_atenea/src/domain/repositories/session_repository.dart';

class GetSessionUseCase {
  final SessionRepository repository;

  const GetSessionUseCase(this.repository);

  Future<Session?> call() async {
    return await repository.getSession();
  }
}

class SaveSessionUseCase {
  final SessionRepository repository;

  const SaveSessionUseCase(this.repository);

  Future<void> call(Session session) async {
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
