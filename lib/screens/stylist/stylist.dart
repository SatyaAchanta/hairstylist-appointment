import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../screens/stylist/appointment_date.dart';
import '../../screens/stylist/stylist_dropdown.dart';
import '../../screens/stylist/stylist_timings.dart';
import '../../screens/stylist/schedule_appointment_button.dart';

class Stylist extends StatelessWidget {
  Stylist({Key? key}) : super(key: key);
  final String selectHairstylist = "Select Hairstylist";

  void onStylistChange(String stylistName) {
    print("--- stylist changed to $stylistName");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppointmentDate(),
              StylistDropdown(),
              StylistTimings(),
              ScheduleAppointment(),
            ],
          ),
        ),
      ),
    );
  }
}
