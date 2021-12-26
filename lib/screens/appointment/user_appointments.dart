import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/appointment_controller.dart';

class UserAppointments extends GetView<AppointmentController> {
  UserAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("--- inside buildWidget");
    controller.getAllUserAppointments();
    return GetX<AppointmentController>(
      builder: (allAppointments) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: allAppointments.userAppointments.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                allAppointments.userAppointments[index].stylistName,
              ),
            );
          },
        );
      },
    );
  }
}
