import 'package:intl/intl.dart';

class DateUtil {
  static String convertDateTimeToString(DateTime dateTime) {
    var appointmentDate = DateTime.now();
    var newFormat = DateFormat("yyyy-MM-dd");
    String _formattedDateTime = newFormat.format(appointmentDate);
    print(_formattedDateTime);
    return _formattedDateTime;
  }
}
