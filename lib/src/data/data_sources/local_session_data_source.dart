import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/permission_entity.dart';

class LocalSessionDataSource {
  final SharedPreferences sharedPreferences;

  LocalSessionDataSource(this.sharedPreferences);

  Future<SessionEntity?> getSession() async {
    try {
      final token = sharedPreferences.getString('session_token');
      final userId = sharedPreferences.getString('user_id');
      final userPermissionsJson = sharedPreferences.getString('user_permissions');
      final tokenValidUntilString = sharedPreferences.getString('token_valid_until');

      if (token != null && userId != null && userPermissionsJson != null && tokenValidUntilString != null) {
        final  userPermissions = PermissionEntity(isSuper: false, academy: [], subject: []);
        
           /*
        Still deciding hows gona be this part
        (jsonDecode(userPermissionsJson) as List)
            .map((e) => PermissionEntity.fromJson(e))
            .toList();*/

        final tokenValidUntil = DateTime.parse(tokenValidUntilString);

        return SessionEntity(
          token: token,
          userId: userId,
          userPermissions: userPermissions,
          tokenValidUntil: tokenValidUntil,
        );
      } else {
        return null; // Si alguno de los valores no está presente, retornamos null
      }
    } catch (e) {
      print('Error al obtener la sesión: $e');
      return null;
    }
  }

  Future<void> addSession(SessionEntity session) async {
    try {
      await sharedPreferences.setString('session_token', session.token);
      await sharedPreferences.setString('user_id', session.userId);
      
      //await sharedPreferences.setString( 'user_permissions', jsonEncode(session.userPermissions.map((e) => e.toJson()).toList()),);

      await sharedPreferences.setString(
        'token_valid_until',
        session.tokenValidUntil.toIso8601String(),
      );
      
      print('Sesión guardada exitosamente.');
    } catch (e) {
      print('Error al guardar la sesión: $e');
    }
  }

  Future<void> removeSession() async {
    try {
      await sharedPreferences.remove('session_token');
      await sharedPreferences.remove('user_id');
      await sharedPreferences.remove('user_permissions');
      await sharedPreferences.remove('token_valid_until');
      print('Sesión eliminada exitosamente.');
    } catch (e) {
      print('Error al eliminar la sesión: $e');
    }
  }
}
