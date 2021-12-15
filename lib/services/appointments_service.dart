import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentService {
  CollectionReference _appointmentCollection =
      FirebaseFirestore.instance.collection('appointments');
}
