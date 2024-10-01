import 'package:flutter/material.dart';
import 'package:proyect_atenea/domain/entities/session.dart';
import 'package:proyect_atenea/domain/usecases/session_use_cases.dart';

class SessionProvider with ChangeNotifier {
  final GetSessionUseCase getSessionUseCase;
  final SaveSessionUseCase saveSessionUseCase;
  final ClearSessionUseCase clearSessionUseCase;

  Session? _session;
  Session? get session => _session;

  SessionProvider({
    required this.getSessionUseCase,
    required this.saveSessionUseCase,
    required this.clearSessionUseCase,
  });

  Future<void> loadSession() async {
    _session = await getSessionUseCase();
    notifyListeners();
  }

  Future<void> saveSession(String token) async {
    final session = Session(token: token);
    await saveSessionUseCase(session);
    _session = session;
    notifyListeners();
  }

  Future<void> clearSession() async {
    await clearSessionUseCase();
    _session = null;
    notifyListeners();
  }
}
