import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'models/sample_data.dart';
import 'models/user_details.dart';
import 'models/appointment_details_provider.dart';
import 'models/user_details_provider.dart';
import 'storage/hairstylistService.dart';

class AboutStylist extends StatelessWidget {
  final HairstylistService hairstylistService = new HairstylistService();
  static const routeName = "/stylistOverview";

  Future<void> _selectDate(
    BuildContext context,
    AppointmentDetailsProvider appointmentDetailsProvider,
    DateTime today,
    DateTime selectedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(
        today.year,
        today.month,
        today.day + 7, // only accept appointments for next one week
      ),
    );
    if (pickedDate != null && pickedDate != today) selectedDate = pickedDate;
    appointmentDetailsProvider.appointmentDetails.appointmentDate =
        DateFormat.MMMEd().format(selectedDate);

    // stylistTimings.clear();
  }

  void getStylistTimings(String stylistName, DateTime appointmentDate) async {
    List<String> timings = await hairstylistService.getStylistTimings(
      stylistName,
      appointmentDate,
    );

    // TODO: replace this with provider call
    /*setState(() {
      stylistTimings.clear();
      stylistTimings.addAll(timings);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);
    final appointmentDetails = Provider.of<AppointmentDetailsProvider>(context);

    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size deviceSize = mediaQuery.size;
    UserDetails user = userDetailsProvider.userInfo;
    String selectedStylistValue = stylistNames[0];
    List<String> stylistTimings = [];
    List<String> hairStylistServices = [];
    DateTime today = DateTime.now();
    DateTime selectedDate = DateTime.now();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome ${user.name!.split(" ")[0]}"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: deviceSize.height * 0.05,
                ),
                child: Text(
                  "Select Hairstylist",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: deviceSize.width * 0.10,
                  vertical: deviceSize.height * 0.02,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                      value: selectedStylistValue,
                      iconSize: 24,
                      isExpanded: true,
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      elevation: 0,
                      onChanged: (String? value) {
                        selectedStylistValue = value!;
                        getStylistTimings(selectedStylistValue, selectedDate);
                        appointmentDetails
                            .setHairStylistName(selectedStylistValue);
                      },
                      items: stylistNames.map<DropdownMenuItem<String>>((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle_rounded,
                                size: deviceSize.width * 0.04,
                                color: isStylistAvailable(value)
                                    ? Colors.green
                                    : Colors.red,
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
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: deviceSize.height * 0.01,
                ),
                child: CircleAvatar(
                  minRadius: deviceSize.aspectRatio * 50,
                  maxRadius: deviceSize.aspectRatio * 100,
                  child: Image.asset("assets/images/profile.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: deviceSize.width * 0.05,
                  vertical: deviceSize.height * 0.05,
                ),
                child: Center(
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: deviceSize.height * 0.01,
                      horizontal: deviceSize.width * 0.02,
                    ),
                    child: Text(
                      DateFormat.MMMEd().format(selectedDate),
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => this._selectDate(
                      context,
                      appointmentDetails,
                      today,
                      selectedDate,
                    ),
                    iconSize: 20,
                    icon: Icon(
                      Icons.edit,
                    ),
                  ),
                ],
              ),
              FutureBuilder<List<String>>(
                future: hairstylistService.getStylistTimings(
                  selectedStylistValue,
                  selectedDate,
                ), // function where you call your api
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text('Please wait its loading...'));
                  } else {
                    if (snapshot.hasError)
                      return Center(child: Text('Error: ${snapshot.error}'));
                    else
                      return Container(
                        margin: EdgeInsets.only(
                          top: deviceSize.height * 0.01,
                        ),
                        child: GroupButton(
                          spacing: 10,
                          selectedColor: Colors.green,
                          borderRadius: BorderRadius.circular(5.0),
                          buttons: snapshot.data!.toList(),
                          onSelected: (i, selected) => {
                            print("Yes"),
                            print(stylistTimings[i]),
                            appointmentDetails.appointmentTime =
                                stylistTimings[i],
                          },
                        ),
                      );
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(
                  top: deviceSize.height * 0.025,
                ),
                child: Center(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("lkjlkjlk");
                    },
                    child: Text('Next'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
