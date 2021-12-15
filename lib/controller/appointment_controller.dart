import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import '../models/appointment.dart';
import '../models/stylist.dart';
import '../services/appointments_service.dart';
import '../services/stylist_service.dart';
import '../utils/date_util.dart';

class AppointmentController extends GetxController {
  final appointment = Appointment(appointmentDate: DateTime.now()).obs;
  final AppointmentService service = Get.put(AppointmentService());
  final StylistService stylistService = Get.put(StylistService());

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

  void scheduleAppointment(String useremail) async {
    /**
     * Steps:
     * 1. using stylistname, check whether time is still available
     * 2. If so, update available and unavailable timings lists for stylist
     * 3. Then, add appointment details to document with useremail in appointments collection
     */
    var appointmentInfo = appointment.value;
    String appointmentDate = DateUtil.convertDateTimeToString(
      appointmentInfo.appointmentDate,
    );

    Stylist stylist = await getStylist(appointmentInfo.stylistName);
    bool isStylistAvailable = await this.checkIfStylistIsAvailable(
      stylist,
      appointmentInfo.appointmentTime,
      appointmentDate,
    );

    if (isStylistAvailable) {
      Stylist stylistWithUpdatedTimings = this.updateStylistTimings(
        stylist,
        appointmentInfo.appointmentTime,
        appointmentDate,
      );

      stylistService.updateStylistTimings(stylistWithUpdatedTimings);
    }
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

  Future<Stylist> getStylist(String stylistName) async {
    Map<String, dynamic>? response =
        await stylistService.getStylist(stylistName);

    return Stylist.fromJson(response!);
  }

  Future<bool> checkIfStylistIsAvailable(
    Stylist stylist,
    String appointmentTime,
    String appointmentDate,
  ) async {
    List<String>? availableTimes = stylist.availableTimes[appointmentDate];

    return availableTimes!.contains(appointmentTime);
  }

  Stylist updateStylistTimings(
    Stylist stylist,
    String appointmentTime,
    String appointmentDate,
  ) {
    stylist.availableTimes[appointmentDate]!.remove(appointmentTime);
    stylist.unavailableTimes[appointmentDate]!.add(appointmentTime);

    return stylist;
  }
}
