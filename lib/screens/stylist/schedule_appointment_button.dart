import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/stylist_controller.dart';
import '../../controller/appointment_controller.dart';
import '../../controller/user_auth_controller.dart';

class ScheduleAppointment extends StatelessWidget {
  ScheduleAppointment({Key? key}) : super(key: key);
  final StylistController stylistController = Get.put(StylistController());
  final UserAuthController userController = Get.put(UserAuthController());
  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          child: Text(
            "Schedule Appointment",
            style: GoogleFonts.roboto(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Get.defaultDialog(
              backgroundColor: Colors.green.shade500,
              title: "Confirm",
              content: Text(
                "Your appointment is at 12:30 PM, Saturday",
              ),
              textConfirm: "Confirm",
              textCancel: "Cancel",
              onConfirm: () {
                appointmentController.scheduleAppointment(
                  userController.user.value.name,
                );
                Get.back();
              },
              onCancel: () {
                Get.back();
              },
              confirmTextColor: Colors.green,
              cancelTextColor: Colors.red,
              buttonColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
                vertical: Get.height * 0.02,
              ),
            );
          },
        ),
      ),
    );
  }
}
