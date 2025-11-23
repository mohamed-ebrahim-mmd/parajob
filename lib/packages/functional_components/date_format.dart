//Mary Mark ||  mary.mark@moselaymd.com || Sun Nov 23 2025 12:58:49

  import 'package:intl/intl.dart';

String getFormattedDate(String dateString, {String locale = 'en'}) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('d MMMM yyyy', locale).format(dateTime);
    } catch (_) {
      return dateString; // Return the original string if parsing fails
    }
  }