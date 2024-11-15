import 'package:intl/intl.dart';

class AppUiHelpers {
  static String formatDateStringToWords(String dateString) {
    try {
      final DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(dateString);
      final String formattedDate = DateFormat("d 'de' MMMM 'de' y - h:mm a", 'es').format(dateTime);
      return formattedDate;
    } catch (e) {
      print('Error formateando la fecha: $e');
      return 'Fecha inválida';
    }
  }
}