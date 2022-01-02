import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

class MockDocumentReference extends Mock implements DocumentReference {
  @override
  Future<void> update(Map<String, Object?> data) {
    throw FirebaseException(plugin: "firestore");
  }
}
