import 'dart:convert';

import 'package:proyect_atenea/src/domain/entities/session_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionLocalDataSource {
  static const String _sessionKey = 'session_data';
  final SharedPreferences prefs;

  SessionLocalDataSource(this.prefs);

  Future<void> saveSession(SessionEntity session) async {
    final sessionJson = jsonEncode(session.toMap());
    await prefs.setString(_sessionKey, sessionJson);
  }

  Future<SessionEntity?> loadSession() async {
    final sessionJson = prefs.getString(_sessionKey);
    if (sessionJson != null) {
      final sessionMap = jsonDecode(sessionJson) as Map<String, dynamic>;
      return SessionEntity.fromMap(sessionMap);
    }
    return null;
  }

  Future<void> clearSession() async {
    await prefs.remove(_sessionKey);
  }
}
