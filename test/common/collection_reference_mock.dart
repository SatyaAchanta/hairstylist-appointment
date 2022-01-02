import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

class MockCollectionReference extends Mock implements CollectionReference {
  @override
  DocumentReference<Object?> doc([String? path]) {
    throw FirebaseException(plugin: "firestore");
  }
}
