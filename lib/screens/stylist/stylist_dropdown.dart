import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../controller/stylist_controller.dart';
import '../../controller/appointment_controller.dart';

class StylistDropdown extends StatelessWidget {
  final StylistController stylistController = Get.put(StylistController());
  final AppointmentController appointmentController =
      Get.put(AppointmentController());
  StylistDropdown({Key? key}) : super(key: key);

  void onStylistChange(String stylistName) {
    print("--- stylist changed to $stylistName");
    stylistController.updateStylist(
      stylistName,
      appointmentController.appointment.value.appointmentDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size deviceSize = mediaQuery.size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: deviceSize.width * 0.1,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select Hairstylist",
              style: GoogleFonts.roboto(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GetX<StylistController>(builder: (_) {
            return Container(
              margin: EdgeInsets.symmetric(
                vertical: deviceSize.height * 0.01,
              ),
              child: DropdownButton(
                  value: _.stylist.value.name,
                  iconSize: 24,
                  isExpanded: true,
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  elevation: 0,
                  onChanged: (String? value) {
                    this.onStylistChange(value!);
                  },
                  items: _.allStylists?.map<DropdownMenuItem<String>>((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle_rounded,
                            size: deviceSize.width * 0.04,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: deviceSize.width * 0.10,
                          ),
                          Text(
                            value,
                            style: GoogleFonts.roboto(
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                      value: value,
                    );
                  }).toList()),
            );
          }),
        ],
      ),
    );
  }
}
