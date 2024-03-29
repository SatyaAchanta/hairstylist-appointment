import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import '../models/stylist.dart';
import '../services/stylist_service.dart';

class StylistController extends GetxController {
  final stylist = Stylist(
    name: "name1",
    availableTimes: Map<String, List<String>>(),
    unavailableTimes: Map<String, List<String>>(),
  ).obs;
  final stylistService = Get.put(StylistService());
  List<String> allStylists = <String>[].obs;

  @override
  void onInit() {
    fetchStylists();
    super.onInit();
  }

  void fetchStylists() async {
    List<Stylist> stylists = [];
    List<Map<String, dynamic>>? response =
        await stylistService.getAllStylists();

    for (var stylistInfo in response!) {
      allStylists.add(stylistInfo["name"]);
      stylists.add(Stylist.fromJson(stylistInfo));
    }

    stylist.update((val) {
      val!.name = stylists[0].name;
      val.age = stylists[0].age;
      val.availableTimes = stylists[0].availableTimes;
      val.unavailableTimes = stylists[0].unavailableTimes;
    });
  }

  void updateStylist(String stylistName) async {
    Map<String, dynamic>? stylistInfo =
        await stylistService.getStylist(stylistName);

    Stylist stylistSelected = Stylist.fromJson(stylistInfo!);

    stylist.update((val) {
      val!.name = stylistSelected.name;
      val.age = stylistSelected.age;
      val.availableTimes = stylistSelected.availableTimes;
      val.unavailableTimes = stylistSelected.unavailableTimes;
    });
  }
}
