import 'dart:collection';

class UiUtilities {
  /// Convierte un HashMap<int, T> en una lista de valores ordenados por la clave.
  /// Retorna `null` si la transacción no puede realizarse.
  static List<T>? hashMapToOrderedList<T>(HashMap<int, T>? hashMap) {
    try {
      if (hashMap == null || hashMap.isEmpty) {
        return null; // Retornar null si el HashMap es nulo o está vacío
      }
      // Ordenar las claves del HashMap
      final sortedKeys = hashMap.keys.toList()..sort();
      // Construir la lista ordenada de valores
      return sortedKeys.map((key) => hashMap[key]!).toList();
    } catch (e) {
      // Capturar cualquier excepción y retornar null
      return null;
    }
  }
}
