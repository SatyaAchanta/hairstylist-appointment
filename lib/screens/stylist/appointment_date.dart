import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../controller/appointment_controller.dart';

class AppointmentDate extends StatelessWidget {
  AppointmentDate({Key? key}) : super(key: key);
  final appointmentController = Get.put(AppointmentController());

  Future<void> _selectDate(
    BuildContext context,
    DateTime today,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(
        today.year,
        today.month,
        today.day + 7, // only accept appointments for next one week
      ),
    );

    if (pickedDate != null && pickedDate != today) {
      print("---- dateChanged");
      appointmentController.setAppointmentDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size deviceSize = mediaQuery.size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: deviceSize.width * 0.1,
        vertical: deviceSize.height * 0.05,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Select Date",
              style: GoogleFonts.roboto(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GetX<AppointmentController>(
            builder: (_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.0,
                    ),
                    child: Text(
                      DateFormat.MMMEd()
                          .format(_.appointment.value.appointmentDate),
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => this._selectDate(
                      context,
                      today,
                    ),
                    iconSize: 20,
                    icon: Icon(
                      Icons.calendar_today_outlined,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
