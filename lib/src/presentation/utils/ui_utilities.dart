import 'dart:collection';

class UiUtilities {
  static List<T>? hashMapToOrderedList<T>(HashMap<int, T>? hashMap) {
    try {
      if (hashMap == null || hashMap.isEmpty) {
        return null; // Retornar null si el HashMap es nulo o está vacío
      }
      final sortedKeys = hashMap.keys.toList()..sort();
      // Construir la lista ordenada de valores
      return sortedKeys.map((key) => hashMap[key]!).toList();
    } catch (e) {
      return null;
    }
  }

  static HashMap<int, T> orderedListToHashMap<T>(List<T> list) {
    final hashMap = HashMap<int, T>();
    for (int i = 0; i < list.length; i++) {
      hashMap[i + 1] = list[i];
    }
    return hashMap;
  }
}