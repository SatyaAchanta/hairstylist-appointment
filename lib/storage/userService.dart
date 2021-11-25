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
      AppointmentDetails appointmentDetails, UserDetails user) {
    var dt = DateTime.now();
    var newFormat = DateFormat("yy-MM-dd");
    String currentDate = newFormat.format(dt);

    String documentId =
        user.email! + "_" + currentDate + "_" + dt.second.toString();

    try {
      return _appointments.doc(documentId).set({
        'appointmentTime': appointmentDetails.appointmentTime,
        'services': appointmentDetails.selectedServices,
        'stylist': appointmentDetails.hairStylistName,
        'appointmentDate': appointmentDetails.appointmentDate,
      });
    } on Exception {
      print("---- couldn't write to appointments collection");
      throw Exception("Unable to schedule appointment");
    }
  }
}
