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
    print("-- appointmentInfo is ${appointmentInfo.toString()}");
    try {
      await _appointmentCollection.doc(useremail).update({
        "appointments": FieldValue.arrayUnion([appointmentInfo]),
      });
      return true;
    } catch (e) {
      print("-- appointmentSchedule failed");
      return false;
    }
  }

  Future<List<Appointment>> getUserAppointments(
    String useremail,
  ) async {
    List<Appointment> allAppointments = [];
    try {
      DocumentReference userAppointments =
          _appointmentCollection.doc(useremail);
      var docSnapshot = await userAppointments.get();

      if (docSnapshot.exists) {
        List<Map<String, dynamic>>? appointments =
            docSnapshot.data() as List<Map<String, dynamic>>;

        for (var appointment in appointments) {
          allAppointments.add(Appointment.fromJson(appointment));
        }
      }

      print("--- total userAppointments are ${allAppointments.length}");
      return allAppointments;
    } catch (e) {
      print("-- appointmentSchedule failed");
      return allAppointments;
    }
  }
}
