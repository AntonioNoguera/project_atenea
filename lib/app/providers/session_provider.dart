import 'package:flutter/material.dart';
import 'package:proyect_atenea/domain/entities/session.dart';
import 'package:proyect_atenea/domain/use_cases/session_use_cases.dart';

class SessionProvider with ChangeNotifier {
  final GetSessionUseCase _getSessionUseCase;
  final SaveSessionUseCase _saveSessionUseCase;
  final ClearSessionUseCase _clearSessionUseCase;

  Session? _session;

  SessionProvider({
    required GetSessionUseCase getSessionUseCase,
    required SaveSessionUseCase saveSessionUseCase,
    required ClearSessionUseCase clearSessionUseCase,
  })  : _getSessionUseCase = getSessionUseCase,
        _saveSessionUseCase = saveSessionUseCase,
        _clearSessionUseCase = clearSessionUseCase;

  bool hasSession() => _session != null;

  Future<void> loadSession() async {
    _session = await _getSessionUseCase();
    notifyListeners();
  }

  Future<void> saveSession(String token) async {
    final session = Session(token: token);
    await _saveSessionUseCase(session);
    _session = session;
    notifyListeners();
  }

  Future<void> clearSession() async {
    await _clearSessionUseCase();
    _session = null;
    notifyListeners();
  }
}
