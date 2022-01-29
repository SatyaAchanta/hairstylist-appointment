import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment.dart';
import '../repositories/appointment_repository.dart';

class AppointmentService {
  late AppointmentRepository repository;

  AppointmentService([var appointmentRepo]) {
    repository =
        appointmentRepo != null ? appointmentRepo : AppointmentRepository();
  }

  Future<bool> scheduleAppointment(
    Appointment appointment,
    String useremail,
  ) async {
    try {
      await repository.scheduleApppointment(useremail, appointment);
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
      DocumentSnapshot docSnapshot =
          await repository.getUserAppointments(useremail);

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
