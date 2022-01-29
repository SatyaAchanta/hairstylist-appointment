import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hairstylist_appointment/models/appointment.dart';
import 'package:hairstylist_appointment/repositories/appointment_repository.dart';
import 'package:hairstylist_appointment/services/appointments_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../firebase_mock.dart';
import 'appointment_service_test.mocks.dart';

@GenerateMocks([AppointmentRepository])
void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group("Test Appointment Service", () {
    test("schedule appointment should return true on successful scheduling",
        () async {
      final appointmentService =
          AppointmentService(MockAppointmentRepository());
      Appointment mockAppointment =
          new Appointment(appointmentDate: DateTime.now());

      when(appointmentService.repository
              .scheduleApppointment("useremail", mockAppointment))
          .thenAnswer((_) => Future.value(true));
      bool scheduleAppointmentResponse = await appointmentService
          .scheduleAppointment(mockAppointment, "useremail");
      expect(scheduleAppointmentResponse, true);
    });

    test("schedule appointment should return false on exception", () async {
      final appointmentService =
          AppointmentService(MockAppointmentRepository());
      Appointment mockAppointment =
          new Appointment(appointmentDate: DateTime.now());

      when(appointmentService.repository
              .scheduleApppointment("useremail", mockAppointment))
          .thenThrow(Exception("failed"));
      bool scheduleAppointmentResponse = await appointmentService
          .scheduleAppointment(mockAppointment, "useremail");
      expect(scheduleAppointmentResponse, false);
    });
  });
}
