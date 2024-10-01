import 'package:proyect_atenea/domain/entities/session.dart';
import 'package:proyect_atenea/domain/repositories/session_repository.dart';

class GetSessionUseCase {
  final SessionRepository repository;

  GetSessionUseCase(this.repository);

  Future<Session?> call() async {
    return await repository.getSession();
  }
}

class SaveSessionUseCase {
  final SessionRepository repository;

  SaveSessionUseCase(this.repository);

  Future<void> call(Session session) async {
    await repository.saveSession(session);
  }
}

class ClearSessionUseCase {
  final SessionRepository repository;

  ClearSessionUseCase(this.repository);

  Future<void> call() async {
    await repository.clearSession();
  }
}
