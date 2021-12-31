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

  Future<List<Appointment>> getUserAppointments(
    String useremail,
  ) async {
    List<Appointment> allAppointments = [];
    try {
      DocumentReference userAppointments =
          _appointmentCollection.doc(useremail);
      var docSnapshot = await userAppointments.get();

      if (docSnapshot.exists) {
        print("--- doc exists");
        Map<String, dynamic> appointmentsMap =
            docSnapshot.data() as Map<String, dynamic>;

        for (var appointment in appointmentsMap['appointments']) {
          allAppointments.add(Appointment.fromJson(appointment));
        }
        print("--- total appointments are ${allAppointments.length}");
      }

      print("--- total userAppointments are ${allAppointments.length}");
      return allAppointments;
    } catch (e) {
      print("-- retrieveing userAppointments failed because ${e.toString()}");
      return allAppointments;
    }
  }
}
