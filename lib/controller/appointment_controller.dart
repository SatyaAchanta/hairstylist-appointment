import 'package:get/state_manager.dart';
import '../models/appointment.dart';

class AppointmentController extends GetxController {
  final appointment = Appointment(appointmentDate: DateTime.now()).obs;

  void setAppointmentDate(DateTime appointmentDate) {
    appointment.update((val) {
      val!.appointmentDate = appointmentDate;
    });
  }

  set appointmentTime(String appointmentTime) {
    appointment().appointmentTime = appointmentTime;

    // TODO: using both appointment date and time
    // set appointmentTimestamp
  }
}
