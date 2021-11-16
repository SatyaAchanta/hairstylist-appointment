import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'appointment_confirmation.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/sample_data.dart';
import 'models/appointment_details_provider.dart';

class Services extends StatefulWidget {
  static const routeName = "/services";
  const Services({Key? key}) : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  String selectedStylistValue = stylistNames[0];
  List<String> hairStylistServices = [];
  List<String> selectedServices = [];

  @override
  void initState() {
    super.initState();
    hairStylistServices = getStylistServices(selectedStylistValue);
  }

  void updateServiceSelection(String serviceName) {
    setState(() {
      if (selectedServices.contains(serviceName)) {
        selectedServices.remove(serviceName);
      } else {
        selectedServices.add(serviceName);
      }
    });
  }

  bool isServiceSelected(String serviceName) {
    print("--- selectedServices are: $selectedServices");
    return selectedServices.contains(serviceName);
  }

  void finalizeSelectedServices(
      List<String> services, AppointmentDetailsProvider appointmentDetails) {
    appointmentDetails.servicesSelected = services;
    Navigator.of(context).pushNamed(AppointmentConfirmation.routeName);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size deviceSize = mediaQuery.size;
    final appointmentDetails =
        Provider.of<AppointmentDetailsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Select Services",
          style: GoogleFonts.roboto(fontSize: 20.0),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              finalizeSelectedServices(
                this.selectedServices,
                appointmentDetails,
              );
            },
            icon: Icon(
              Icons.navigate_next,
              color: Colors.white,
              size: deviceSize.height * 0.05,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: hairStylistServices.length,
        itemBuilder: (context, i) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 0.1,
            ),
            child: CheckboxListTile(
              dense: false,
              value: isServiceSelected(hairStylistServices[i]),
              onChanged: (bool? isSelected) => {
                setState(
                  () {
                    updateServiceSelection(hairStylistServices[i]);
                  },
                ),
              },
              title: Text(hairStylistServices[i]),
            ),
          );
        },
      ),
    );
  }
}
