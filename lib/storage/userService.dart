import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_details.dart';

class UserService {
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

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

  // int convertAppointmentDateToMilliseconds(AppointmentDetails details) {
  //   var appointmentDateInMillis = DateTime.parse(details.appointmentDate);
  //   int addAppointmentTime = addTimeToAppointmentDate(
  //       appointmentDateInMillis, details.appointmentTime);
  //   return addAppointmentTime;
  // }

  // int addTimeToAppointmentDate(
  //     DateTime appointmentDateInMillis, String appointmentTime) {
  //   List<String> timeOfTheDay = appointmentTime.split(" ");
  //   String meridian = timeOfTheDay.elementAt(1);
  //   List<String> appointmentHoursAndMinutes = timeOfTheDay[0].split(":");
  //   int appointmentHours = int.parse(appointmentHoursAndMinutes[0]);
  //   int appointmentMinutes = int.parse(appointmentHoursAndMinutes[1]);
  //   int totalHoursToBeAdded =
  //       meridian == "PM" ? appointmentHours + 12 : appointmentHours;
  //   return appointmentDateInMillis
  //       .add(Duration(hours: totalHoursToBeAdded, minutes: appointmentMinutes))
  //       .millisecondsSinceEpoch;
  // }
}
