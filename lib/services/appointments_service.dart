import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentService {
  CollectionReference _appointmentCollection =
      FirebaseFirestore.instance.collection('appointments');

  Future<Map<String, dynamic>?> getStylistTimings(String stylistName) async {
    DocumentReference _stylistDoc =
        _appointmentCollection.doc(stylistName.toLowerCase());

    var docSnapshot = await _stylistDoc.get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? stylistInfo =
          docSnapshot.data() as Map<String, dynamic>;

      return stylistInfo;
    }

    return Map<String, dynamic>();
  }
}
