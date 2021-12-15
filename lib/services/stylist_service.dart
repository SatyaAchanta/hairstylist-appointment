import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/stylist.dart';

class StylistService {
  CollectionReference _stylistCollection =
      FirebaseFirestore.instance.collection('stylists');

  Future<List<Map<String, dynamic>>?> getAllStylists() async {
    List<Map<String, dynamic>> stylits = [];

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _stylistCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print("---- allData Length is ${allData.length}");
    for (var data in allData) {
      Map<String, dynamic>? dataMap = data as Map<String, dynamic>?;

      if (!dataMap!.containsKey("stylists")) {
        print(dataMap);
        stylits.add(dataMap);
      }
    }

    return stylits;
  }

  Future<Map<String, dynamic>?> getStylist(String stylistName) async {
    DocumentReference _stylistDoc =
        _stylistCollection.doc(stylistName.toLowerCase());

    var docSnapshot = await _stylistDoc.get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? stylistInfo =
          docSnapshot.data() as Map<String, dynamic>;

      return stylistInfo;
    }

    return Map<String, dynamic>();
  }

  Future<bool> updateStylistTimings(Stylist stylist) async {
    Map<String, dynamic> stylistInfo = stylist.toJson();
    try {
      await _stylistCollection.doc(stylistInfo["name"]).update(stylistInfo);
      return true;
    } catch (e) {
      return false;
    }
  }
}
