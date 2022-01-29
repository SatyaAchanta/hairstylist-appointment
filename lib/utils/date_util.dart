import 'package:intl/intl.dart';

class DateUtil {
  static String convertDateTimeToString(DateTime dateTime) {
    var newFormat = DateFormat("yyyy-M-d");
    String _formattedDateTime = newFormat.format(dateTime);
    print(_formattedDateTime);
    return _formattedDateTime;
  }
}
