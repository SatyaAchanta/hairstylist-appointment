import 'package:hairstylist_appointment/utils/date_util.dart';
import 'package:test/test.dart';

void main() {
  group("Date Util Test", () {
    test("returns Shortform of date for received DateTime", () {
      var expectedDateTime = DateTime(2021, 12, 26, 7, 17, 30);

      String actualDateTime =
          DateUtil.convertDateTimeToString(expectedDateTime);

      expect(actualDateTime, equals("2021-12-26"));
    });
  });
}
