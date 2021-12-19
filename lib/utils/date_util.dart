import 'package:intl/intl.dart';

class DateUtil {
  static String convertDateTimeToString(DateTime dateTime) {
    var newFormat = DateFormat("yyyy-MM-dd");
    String _formattedDateTime = newFormat.format(dateTime);
    print(_formattedDateTime);
    return _formattedDateTime;
  }
}
