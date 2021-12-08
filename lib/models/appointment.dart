import 'package:get/get_state_manager/get_state_manager.dart';

class Appointment extends GetxController {
  DateTime appointmentDate;
  String appointmentTime;
  String stylistName;
  int appointmentTimestamp;

  Appointment({
    required this.appointmentDate,
    this.appointmentTimestamp = 0,
    this.appointmentTime = "",
    this.stylistName = "",
  });
}
