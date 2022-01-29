import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/appointment.dart';

class AppointmentRepository {
  CollectionReference repoReference =
      FirebaseFirestore.instance.collection('appointments');
  Future<bool> scheduleApppointment(
      String useremail, Appointment appointment) async {
    try {
      await repoReference.doc(useremail).update({
        "appointments": FieldValue.arrayUnion([appointment.toJson()])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<DocumentSnapshot> getUserAppointments(String useremail) async {
    try {
      DocumentReference userAppointments = repoReference.doc(useremail);
      var docSnapshot = await userAppointments.get();

      return docSnapshot;
    } catch (e) {
      print("-- retrieveing userAppointments failed because ${e.toString()}");
      throw Exception("couldn't retrieve appointments for user");
    }
  }
}
