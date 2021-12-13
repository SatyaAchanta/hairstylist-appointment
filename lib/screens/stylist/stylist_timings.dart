import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controller/stylist_controller.dart';
import '../../controller/appointment_controller.dart';

class StylistTimings extends StatelessWidget {
  final StylistController stylistController = Get.put(StylistController());
  final AppointmentController appointmentController =
      Get.put(AppointmentController());
  StylistTimings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size deviceSize = mediaQuery.size;
    var dateFormat = DateFormat("yyyy-MM-dd");
    String shortDate = dateFormat.format(
      appointmentController.appointment.value.appointmentDate,
    );
    List<String> availableTimes = [];
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: deviceSize.width * 0.1,
        vertical: deviceSize.height * 0.05,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select Time",
              style: GoogleFonts.roboto(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GetX<StylistController>(
            builder: (_) {
              availableTimes = _.stylist.value.availableTimes.isNotEmpty
                  ? _.stylist.value.availableTimes[shortDate]!
                  : [];
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: deviceSize.height * 0.01,
                ),
                child: GroupButton(
                  mainGroupAlignment: MainGroupAlignment.start,
                  spacing: 10,
                  selectedColor: Colors.green,
                  borderRadius: BorderRadius.circular(5.0),
                  buttons: availableTimes,
                  onSelected: (i, selected) => {
                    appointmentController.setAppointmentDetails(
                      availableTimes[i],
                      stylistController.stylist.value.name,
                    ),
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
