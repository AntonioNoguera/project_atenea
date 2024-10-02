import 'package:shared_preferences/shared_preferences.dart';

class SessionLocalDataSource {
  final SharedPreferences sharedPreferences;

  const SessionLocalDataSource(this.sharedPreferences);

  Future<String?> getToken() async {
    return sharedPreferences.getString('session_token');
  }

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString('session_token', token);
  }

  Future<void> clearToken() async {
    await sharedPreferences.remove('session_token');
  }
}
