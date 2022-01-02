import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hairstylist_appointment/models/appointment.dart';
import 'package:hairstylist_appointment/services/appointments_service.dart';
import '../common/collection_reference_mock.dart';
import '../firebase_mock.dart';

void main() {
  setupFirebaseAuthMocks();
  final firestoreCollection =
      FakeFirebaseFirestore().collection("appointments");

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  group("Test Appointment Service", () {
    test("schedule appointment should return true on successful scheduling",
        () async {
      final appointmentService = AppointmentService();
      appointmentService.appointmentCollection = firestoreCollection;
      Appointment mockAppointment =
          new Appointment(appointmentDate: DateTime.now());
      bool scheduleAppointmentResponse = await appointmentService
          .scheduleAppointment(mockAppointment, "useremail");
      expect(scheduleAppointmentResponse, true);
    });

    test(
        "schedule appointment should return false on failing to schedule appointment",
        () async {
      final appointmentService = AppointmentService();
      appointmentService.appointmentCollection = MockCollectionReference();
      Appointment mockAppointment =
          new Appointment(appointmentDate: DateTime.now());
      bool scheduleAppointmentResponse = await appointmentService
          .scheduleAppointment(mockAppointment, "useremail");

      expect(scheduleAppointmentResponse, false);
    });
  });
}
