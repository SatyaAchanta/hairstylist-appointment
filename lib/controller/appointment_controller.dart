import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import '../models/appointment.dart';
import '../models/stylist.dart';
import '../services/appointments_service.dart';
import '../services/stylist_service.dart';
import '../services/auth_service.dart';
import '../controller/stylist_controller.dart';
import '../utils/date_util.dart';

class AppointmentController extends GetxController {
  final appointment = Appointment(appointmentDate: DateTime.now()).obs;
  final userAppointments = [].obs;
  final AppointmentService appointmentService = Get.put(AppointmentService());
  final StylistService stylistService = Get.put(StylistService());
  final AuthService authService = Get.put(AuthService());
  final StylistController stylistController = Get.put(StylistController());
  String userEmail = "";

  void setAppointmentDate(DateTime appointmentDate) {
    appointment.update((val) {
      val!.appointmentDate = appointmentDate;
      print(
          "---- updated appointment time is ${appointment.value.appointmentDate}");
    });
  }

  @override
  void onInit() {
    print("---- inside onInit");
    userEmail = authService.getCurrentUser().email!;
    print("--- userEmail is $userEmail");
    super.onInit();
  }

  void setAppointmentDetails(String appointmentTime, String stylistName) {
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

  Future<bool> scheduleAppointment() async {
    /**
     * Steps:
     * 1. using stylistname, check whether time is still available
     * 2. If so, update available and unavailable timings lists for stylist
     * 3. Then, add appointment details to document with useremail in appointments collection
     */
    var appointmentInfo = this.appointment.value;
    String appointmentDate = DateUtil.convertDateTimeToString(
      appointmentInfo.appointmentDate,
    );

    print("---- appointmentInfo stylistName is ${appointmentInfo.stylistName}");
    Stylist stylist = await getStylist(appointmentInfo.stylistName);
    bool isStylistAvailable = await this.checkIfStylistIsAvailable(
      stylist,
      appointmentInfo.appointmentTime,
      appointmentDate,
    );

    if (isStylistAvailable) {
      print("--- stylist is availale");
      Stylist stylistWithUpdatedTimings = this.updateStylistTimings(
        stylist,
        appointmentInfo.appointmentTime,
        appointmentDate,
      );

      /**
       * if stylist is available
       * reserve stylist timings first
       * and if timings are updated/reserved
       * then add appointment
       */
      bool isStylistTimingUpdated =
          await stylistService.updateStylistTimings(stylistWithUpdatedTimings);

      print("---- stylist timing updated successfully");
      if (isStylistTimingUpdated) {
        print("---- about to schedule appointment");
        bool isAppointmentScheduled = await appointmentService
            .scheduleAppointment(appointment.value, userEmail);

        print("appointment schedule finished");

        if (isAppointmentScheduled) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> getAllUserAppointments() async {
    userAppointments.clear();
    List<Appointment> appointments =
        await appointmentService.getUserAppointments(userEmail);
    userAppointments.addAll(appointments);
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
