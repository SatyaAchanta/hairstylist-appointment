import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/stylist.dart';

class StylistService {
  CollectionReference _stylistCollection =
      FirebaseFirestore.instance.collection('stylists');

  /* Reference code snippet
    Future<List<String>> getStylistTimings(
      String name, DateTime appointmentDate) async {
    List<String> _availableTimes = [];
    DocumentReference _stylistDoc = _stylistCollection.doc(name.toLowerCase());
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
  }*/

  Future<List<Map<String, dynamic>>?> getAllStylists() async {
    List<Map<String, dynamic>> stylits = [];

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _stylistCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print("---- allData Length is ${allData.length}");
    for (var data in allData) {
      Map<String, dynamic>? dataMap = data as Map<String, dynamic>?;

      if (!dataMap!.containsKey("stylists")) {
        print(dataMap);
        stylits.add(dataMap);
      }
    }

    return stylits;
  }

  Future<Map<String, dynamic>> getStylist(String stylistName) async {
    DocumentReference _stylistDoc = _stylistCollection.doc(stylistName);

    var docSnapshot = await _stylistDoc.get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      return data;
    }

    return new Map();
  }

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
    DocumentReference _stylistDoc =
        _stylistCollection.doc(stylistName.toLowerCase());

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
