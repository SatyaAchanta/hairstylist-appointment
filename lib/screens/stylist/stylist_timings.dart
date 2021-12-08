import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import '../../controller/stylist_controller.dart';
import '../../controller/appointment_controller.dart';

class StylistTimings extends StatelessWidget {
  final StylistController stylistController = Get.put(StylistController());
  final AppointmentController appointmentController =
      Get.put(AppointmentController());
  StylistTimings({Key? key}) : super(key: key);

  List<String>? getTimingsForDateSelected() {
    var dateFormat = DateFormat("yyyy-MM-dd");
    String shortDate = dateFormat.format(
      appointmentController.appointment.value.appointmentDate,
    );
    return stylistController.stylist.value.availableTimes[shortDate];
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size deviceSize = mediaQuery.size;
    return Container(
      margin: EdgeInsets.only(
        top: deviceSize.height * 0.01,
      ),
      child: GetX<StylistController>(
        builder: (_) {
          return GroupButton(
            spacing: 10,
            selectedColor: Colors.green,
            borderRadius: BorderRadius.circular(5.0),
            buttons: getTimingsForDateSelected()!,
            onSelected: (i, selected) => {
              stylistController.updateStylist(
                stylistController.stylist.value.name,
                appointmentController.appointment.value.appointmentDate,
              ),
            },
          );
        },
      ),
    );
  }
}
