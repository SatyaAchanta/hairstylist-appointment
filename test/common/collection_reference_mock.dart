import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

import 'document_reference_mock.dart';

class MockCollectionReference extends Mock implements CollectionReference {
  @override
  DocumentReference<Object?> doc([String? path]) {
    print("---inside Mock");
    return MockDocumentReference();
  }
}
