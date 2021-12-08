import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/stylist.dart';

class StylistService {
  CollectionReference _stylistCollection =
      FirebaseFirestore.instance.collection('stylists');

  // Future<List<String>> getStylistTimings(
  //     String name, DateTime appointmentDate) async {
  //   List<String> _availableTimes = [];
  //   DocumentReference _stylistDoc = _stylistCollection.doc(name.toLowerCase());
  //   var newFormat = DateFormat("yyyy-MM-dd");
  //   String _customerPreferredDate = newFormat.format(appointmentDate);
  //   CollectionReference _availableDates = _stylistDoc.collection("schedule");

  //   DocumentReference _schedule = _availableDates.doc(_customerPreferredDate);

  //   var docSnapshot = await _schedule.get();

  //   if (docSnapshot.exists) {
  //     Map<String, dynamic>? timings =
  //         docSnapshot.data() as Map<String, dynamic>?;

  //     List<String> timingsSample =
  //         new List<String>.from(timings!["availableTimes"]);

  //     return timingsSample;
  //   }

  //   return [];
  // }

  Future<List<String>?> get stylistNames async {
    DocumentReference _stylistDoc = _stylistCollection.doc("allStylists");

    var docSnapshot = await _stylistDoc.get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      List<String>? names = new List<String>.from(data!["stylists"]);
      print("---- names are ${names.toString()}");
      return names;
    }

    return [];
  }

  Future<Map<String, dynamic>?> getStylistTimings(String stylistName) async {
    // var newFormat = DateFormat("yyyy-MM-dd");
    // String _preferredAppointmentDate = newFormat.format(appointmentDate);

    DocumentReference _stylistDoc = _stylistCollection.doc(stylistName);

    var docSnapshot = await _stylistDoc.get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? stylistInfo =
          docSnapshot.data() as Map<String, dynamic>;

      return stylistInfo;
    }

    // return emptyString
    return Map<String, dynamic>();
  }
}
