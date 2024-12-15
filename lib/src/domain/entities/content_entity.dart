import 'dart:collection';

class ContentEntity {
  final HashMap<int, String> halfTerm; // Cambiado a HashMap<int, String>
  final HashMap<int, String> ordinary; // Cambiado a HashMap<int, String>

  ContentEntity({
    required this.halfTerm,
    required this.ordinary,
  });

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'halfTerm': halfTerm.map((key, value) => MapEntry(key.toString(), value)), // Convertir claves a String
      'ordinary': ordinary.map((key, value) => MapEntry(key.toString(), value)), // Convertir claves a String
    };
  }

  // Método para convertir desde Map
  factory ContentEntity.fromMap(Map<String, dynamic> data) {
    return ContentEntity(
      halfTerm: HashMap<int, String>.from(
        (data['halfTerm'] ?? {}).map((key, value) => MapEntry(int.parse(key), value)),
      ),
      ordinary: HashMap<int, String>.from(
        (data['ordinary'] ?? {}).map((key, value) => MapEntry(int.parse(key), value)),
      ),
    );
  }
}
