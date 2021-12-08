import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairstylist_appointment/models/appointment_details.dart';
import '../models/user_details.dart';

class UserService {
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  CollectionReference _appointments =
      FirebaseFirestore.instance.collection('appointments');

  Future<void> addUser(String email, String displayName) {
    return _users
        .doc(email)
        .set({
          'name': displayName,
          'email': email,
        })
        .then((value) => print("User added"))
        .catchError((error) => {print("Unable to add user due to $error")});
  }

  Future<void> updateUserDetails(UserDetails user) {
    return _users.doc(user.email).set({
      'gender': user.gender,
      'phoneNumber': user.phoneNumber,
      'age': user.age,
    });
  }

  Future<void> addAppointmentDetails(
    AppointmentDetails appointmentDetails,
    UserDetails user,
  ) {
    String documentId = user.email!;

    int appointmentTime =
        convertAppointmentDateToMilliseconds(appointmentDetails);

    var appointmentData = {
      "scheduleTime": appointmentTime,
      "stylistName": appointmentDetails.hairStylistName,
      "services": appointmentDetails.selectedServices,
    };

    try {
      return _appointments.doc(documentId).update(
        {
          "appointments": appointmentData,
        },
      );
    } on Exception {
      print("---- couldn't write to appointments collection");
      throw Exception("Unable to schedule appointment");
    }
  }

  int convertAppointmentDateToMilliseconds(AppointmentDetails details) {
    var appointmentDateInMillis = DateTime.parse(details.appointmentDate);
    int addAppointmentTime = addTimeToAppointmentDate(
        appointmentDateInMillis, details.appointmentTime);
    return addAppointmentTime;
  }

  int addTimeToAppointmentDate(
      DateTime appointmentDateInMillis, String appointmentTime) {
    List<String> timeOfTheDay = appointmentTime.split(" ");
    String meridian = timeOfTheDay.elementAt(1);
    List<String> appointmentHoursAndMinutes = timeOfTheDay[0].split(":");
    int appointmentHours = int.parse(appointmentHoursAndMinutes[0]);
    int appointmentMinutes = int.parse(appointmentHoursAndMinutes[1]);
    int totalHoursToBeAdded =
        meridian == "PM" ? appointmentHours + 12 : appointmentHours;
    return appointmentDateInMillis
        .add(Duration(hours: totalHoursToBeAdded, minutes: appointmentMinutes))
        .millisecondsSinceEpoch;
  }
}
