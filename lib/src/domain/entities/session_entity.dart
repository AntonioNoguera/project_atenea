import 'package:cloud_firestore/cloud_firestore.dart';

class SessionEntity {
  final String token;
  final String userId;
  final String userName;
  final DateTime tokenValidUntil;
  final List<String> savedSubjects;

  SessionEntity({
    required this.token,
    required this.userId,
    required this.userName,
    required this.tokenValidUntil,
    required this.savedSubjects,
  });

  // Constructor con valores predeterminados
  SessionEntity.defaultValues()
      : token = 'default_token',
        userId = 'default_user_id',
        userName = 'default_user_name',
        savedSubjects = [],
        tokenValidUntil = DateTime.now().add(const Duration(days: 30));

  // Método para convertir a un Map<String, dynamic> para almacenamiento
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'userId': userId,
      'userName': userName,
      'tokenValidUntil': tokenValidUntil.toIso8601String(),
      'savedSubjects': savedSubjects,
    };
  }

  // Método estático para crear una instancia de SessionEntity desde un mapa
  static SessionEntity fromMap(Map<String, dynamic> map) {
    try {
      return SessionEntity(
        token: map['token'] ?? 'default_token',
        userId: map['userId'] ?? 'default_user_id',
        userName: map['userName'] ?? 'default_user_name',
        tokenValidUntil: DateTime.parse(map['tokenValidUntil']),
        savedSubjects: List<String>.from(map['savedSubjects'] ?? []),
      );
    } catch (e) {
      print("Error deserializing SessionEntity from map: $e");
      return SessionEntity.defaultValues(); // Retorna valores por defecto en caso de error
    }
  }
}