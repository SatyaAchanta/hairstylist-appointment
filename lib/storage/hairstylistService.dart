import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HairstylistService {
  CollectionReference _stylists =
      FirebaseFirestore.instance.collection('stylists');

  Future<List<String>> getStylistTimings(
      String name, DateTime appointmentDate) async {
    List<String> _availableTimes = [];
    DocumentReference _stylistDoc = _stylists.doc(name.toLowerCase());
    var newFormat = DateFormat("yyyy-MM-dd");
    String _customerPreferredDate = newFormat.format(appointmentDate);
    CollectionReference _availableDates = _stylistDoc.collection("schedule");

    DocumentReference _schedule = _availableDates.doc(_customerPreferredDate);

    var docSnapshot = await _schedule.get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? timings =
          docSnapshot.data() as Map<String, dynamic>?;

      List<String> timingsSample =
          new List<String>.from(timings!["availableTimes"]);

      return timingsSample;
    }

    return [];
  }
}
