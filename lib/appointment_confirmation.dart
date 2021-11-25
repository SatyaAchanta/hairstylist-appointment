import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairstylist_appointment/models/user_details.dart';
import 'package:hairstylist_appointment/models/appointment_details.dart';
import 'package:provider/provider.dart';
import 'models/appointment_details_provider.dart';
import 'models/user_details_provider.dart';
import 'storage/userService.dart';

class AppointmentConfirmation extends StatelessWidget {
  static const routeName = "/appointmentConfirmation";

  void showConfirmationMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Appointment Confirmed'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Code to execute.
          },
        ),
        duration: const Duration(
          milliseconds: 6000,
        ),
        width: 280.0, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void scheduleAppointment(
    UserService userStorage,
    UserDetails user,
    AppointmentDetails appointmentDetails,
  ) {
    userStorage.addAppointmentDetails(appointmentDetails, user);
  }

  @override
  Widget build(BuildContext context) {
    final UserService userStorage = new UserService();
    final userProvider = Provider.of<UserDetailsProvider>(context);
    final appointment = Provider.of<AppointmentDetailsProvider>(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size deviceSize = mediaQuery.size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirm Appointment",
          style: GoogleFonts.roboto(fontSize: 20.0),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {
              this.scheduleAppointment(
                userStorage,
                userProvider.user,
                appointment.appointmentDetails,
              ),
              this.showConfirmationMessage(context),
            },
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: deviceSize.width * 0.02,
          ),
          child: ExpansionPanelList(
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      'Stylist Selected',
                      style: GoogleFonts.robotoCondensed(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
                },
                body: ListTile(
                  title: Text(
                    appointment.details.hairStylistName,
                    style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),
                  ),
                ),
                isExpanded: true,
              ),
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      'Appointment Date',
                      style: GoogleFonts.robotoCondensed(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
                },
                body: ListTile(
                  title: Text(
                    appointment.details.appointmentDate,
                    style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),
                  ),
                ),
                isExpanded: true,
              ),
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      'Appointment Time',
                      style: GoogleFonts.robotoCondensed(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
                },
                body: ListTile(
                  title: Text(
                    appointment.details.appointmentTime,
                    style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),
                  ),
                ),
                isExpanded: true,
              ),
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      'Services Chosen',
                      style: GoogleFonts.robotoCondensed(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
                },
                body: ListTile(
                  title: Text(
                    appointment.details.selectedServices.join(","),
                    style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),
                  ),
                ),
                isExpanded: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
