import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hairstylist_appointment/models/appointment.dart';
import 'package:hairstylist_appointment/services/appointments_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'appointment_service_test.mocks.dart';

@GenerateMocks([AppointmentService])
void main() {
  final firestore = FakeFirebaseFirestore();
  final appointmentService = MockAppointmentService();
  group("Test Appointment Service", () {
    test("schedule appointment should return true", () async {
      Appointment mockAppointment =
          new Appointment(appointmentDate: DateTime.now());
      await firestore
          .collection("appointments")
          .doc("useremail")
          .update({"appointments": mockAppointment.toJson()});
      when(appointmentService.scheduleAppointment(mockAppointment, "useremail"))
          .thenAnswer((_) => Future.value(true));
      bool scheduleAppointmentResponse = await appointmentService
          .scheduleAppointment(mockAppointment, "useremail");
      expect(scheduleAppointmentResponse, true);
    });
  });
}
