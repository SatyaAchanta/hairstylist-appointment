import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairstylist_appointment/models/appointment.dart';

class AppointmentService {
  CollectionReference _appointmentCollection =
      FirebaseFirestore.instance.collection('appointments');

  Future<bool> scheduleAppointment(
    Appointment appointment,
    String useremail,
  ) async {
    Map<String, dynamic> appointmentInfo = appointment.toJson();
    try {
      await _appointmentCollection.doc(useremail).update({
        "appointments": FieldValue.arrayUnion([appointmentInfo]),
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
