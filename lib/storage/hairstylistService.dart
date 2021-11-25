import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HairstylistService {
  CollectionReference _timings =
      FirebaseFirestore.instance.collection('stylists');
  void getStylistTimings(String name, DateTime appointmentDate) {
    DocumentReference _stylistDoc = _timings.doc(name);
    var newFormat = DateFormat("yy-MM-dd");
    String _customerPreferredDate = newFormat.format(appointmentDate);
    CollectionReference _availableDates = _stylistDoc.collection("schedule");

    DocumentReference _schedule = _availableDates.doc(_customerPreferredDate);

    _schedule
        .get()
        .then(
          (value) => {
            print("---- value is $value"),
          },
        )
        .catchError(
          (error) => {
            print("--- unable to retrieve data due to $error"),
          },
        );
  }
}
