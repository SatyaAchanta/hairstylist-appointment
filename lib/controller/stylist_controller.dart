import 'package:get/state_manager.dart';
import '../models/stylist.dart';
import '../services/stylist_service.dart';

class StylistController extends GetxController {
  final stylist = Stylist(
    name: "name1",
    availableTimes: Map<String, List<String>>(),
    unavailableTimes: Map<String, List<String>>(),
  ).obs;
  final stylistService = new StylistService();
  List<String>? allStylists = <String>[].obs;

  @override
  void onInit() async {
    await stylistService.stylistNames.then(
      (stylistNames) => {
        allStylists = stylistNames,
        stylist.update(
          (val) {
            val!.name = stylistNames![0];
          },
        )
      },
    );
    super.onInit();
  }

  void fetchStylists() async {
    await stylistService.stylistNames.then((value) => allStylists = value);
  }

  void updateStylist(String stylistName, DateTime appointmentDate) async {
    Map<String, dynamic>? stylistInfo =
        await stylistService.getStylistTimings(stylistName);

    stylist.update((val) {
      val = Stylist.convertToStylist(stylistInfo);
    });

    print(stylist.toJson());
  }
}
