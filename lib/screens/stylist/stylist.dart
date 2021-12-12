import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../screens/stylist/appointment_date.dart';
import '../../screens/stylist/stylist_dropdown.dart';
import '../../screens/stylist/stylist_timings.dart';

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
              Container(
                child: Center(
                  child: ElevatedButton.icon(
                    label: Text(
                      "Confirm Appointment",
                      style: GoogleFonts.roboto(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: Icon(
                      Icons.check_sharp,
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
