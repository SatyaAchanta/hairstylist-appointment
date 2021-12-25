import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/appointment_controller.dart';
import '../../controller/user_auth_controller.dart';

class UserAppointments extends StatelessWidget {
  UserAppointments({Key? key}) : super(key: key);
  final AppointmentController controller = Get.put(AppointmentController());
  final UserAuthController userAuthController = Get.put(UserAuthController());

  @override
  Widget build(BuildContext context) {
    print("--- inside buildWidget");
    controller.getAllUserAppointments();
    return Container(
      child: GetX<AppointmentController>(builder: (_) {
        return Text(
          "Total user appointments are ${_.userAppointments.length}",
        );
      }),
    );
  }
}
