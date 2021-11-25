import 'package:flutter/material.dart';
import 'appointment_details.dart';

class AppointmentDetailsProvider extends ChangeNotifier {
  AppointmentDetails appointmentDetails = new AppointmentDetails();

  AppointmentDetailsProvider() {
    appointmentDetails.appointmentTime = "";
    appointmentDetails.hairStylistName = "";
    appointmentDetails.appointmentDate = "";
    appointmentDetails.selectedServices = [];
  }

  set appointmentTime(String time) {
    appointmentDetails.appointmentTime = time;
    notifyListeners();
  }

  void setHairStylistName(String name) {
    appointmentDetails.hairStylistName = name;
    notifyListeners();
  }

  set servicesSelected(List<String> selectedServices) {
    appointmentDetails.selectedServices = selectedServices;
    notifyListeners();
  }

  set appointmentDateSelected(String appointmentDate) {
    appointmentDetails.appointmentDate = appointmentDate;
    notifyListeners();
  }

  AppointmentDetails get details {
    return this.appointmentDetails;
  }
}
