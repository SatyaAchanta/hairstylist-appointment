import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import '../models/appointment.dart';

class AppointmentController extends GetxController {
  final appointment = Appointment(appointmentDate: DateTime.now()).obs;

  void setAppointmentDate(DateTime appointmentDate) {
    appointment.update((val) {
      val!.appointmentDate = appointmentDate;
    });
  }

  void setAppointmentDetails(
    String appointmentTime,
    String stylistName,
  ) {
    appointment.update(
      (val) {
        val!.appointmentTime = appointmentTime;
        val.stylistName = stylistName;
        val.appointmentTimestamp = this.convertAppointmentTimeToMillis(
          appointment.value.appointmentDate,
          appointmentTime,
        );
      },
    );
  }

  void scheduleAppointment(String useremail) {
    /**
     * Steps:
     * 1. using stylistname, check whether time is still available
     * 2. If so, update available and unavailable timings lists for stylist
     * 3. Then, add appointment details to document with useremail in appointments collection
     */
  }

  int convertAppointmentTimeToMillis(
      DateTime appointmentDate, String appointmentTime) {
    List<String> timeOfTheDay = appointmentTime.split(" ");
    String meridian = timeOfTheDay.elementAt(1);
    List<String> appointmentHoursAndMinutes = timeOfTheDay[0].split(":");
    int appointmentHours = int.parse(appointmentHoursAndMinutes[0]);
    int appointmentMinutes = int.parse(appointmentHoursAndMinutes[1]);
    int totalHoursToBeAdded =
        meridian == "PM" ? appointmentHours + 12 : appointmentHours;
    return appointmentDate
        .add(Duration(hours: totalHoursToBeAdded, minutes: appointmentMinutes))
        .millisecondsSinceEpoch;
  }
}
