import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/stylist_controller.dart';
import '../../screens/stylist/appointment_date.dart';
import '../../screens/stylist/stylist_dropdown.dart';

class Stylist extends StatelessWidget {
  Stylist({Key? key}) : super(key: key);
  final String selectHairstylist = "Select Hairstylist";

  void onStylistChange(String stylistName) {
    print("--- stylist changed to $stylistName");
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size deviceSize = mediaQuery.size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppointmentDate(),
              StylistDropdown(),
            ],
          ),
        ),
      ),
    );
  }
}
