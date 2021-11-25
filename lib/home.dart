import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hairstylist_appointment/models/user_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'services.dart';
import 'models/sample_data.dart';
import 'models/user_details.dart';
import 'models/appointment_details_provider.dart';

class Home extends StatefulWidget {
  static const routeName = "/stylistOverview";
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedStylistValue = stylistNames[0];
  List<String> stylistTimings = [];
  List<String> hairStylistServices = [];
  DateTime appointmentDate = DateTime.now();

  retrieveAvailableTimings(String selectedHairstylist) {
    stylistTimings = getStylistTimings(selectedHairstylist);
  }

  Future<void> _selectDate(
    BuildContext context,
    AppointmentDetailsProvider appointmentDetailsProvider,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: appointmentDate,
      firstDate: DateTime(
          appointmentDate.year, appointmentDate.month, appointmentDate.day),
      lastDate: DateTime(
        appointmentDate.year,
        appointmentDate.month,
        appointmentDate.day + 7, // only accept appointments for next one week
      ),
    );
    if (pickedDate != null && pickedDate != appointmentDate)
      setState(() {
        appointmentDate = pickedDate;
        appointmentDetailsProvider.appointmentDetails.appointmentDate =
            DateFormat.MMMEd().format(appointmentDate);
      });
  }

  @override
  void initState() {
    super.initState();
    stylistTimings = getStylistTimings(selectedStylistValue);
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size deviceSize = mediaQuery.size;
    final appointmentDetails =
        Provider.of<AppointmentDetailsProvider>(context, listen: false);

    UserDetails user = userDetailsProvider.userInfo;

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
                        setState(() => {
                              selectedStylistValue = value!,
                              this.hairStylistServices =
                                  getStylistServices(selectedStylistValue),
                              retrieveAvailableTimings(selectedStylistValue),
                              appointmentDetails
                                  .setHairStylistName(selectedStylistValue),
                            });
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
                      DateFormat.MMMEd().format(appointmentDate),
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
                    ),
                    iconSize: 20,
                    icon: Icon(
                      Icons.edit,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: deviceSize.height * 0.01,
                ),
                child: GroupButton(
                    spacing: 10,
                    selectedColor: Colors.green,
                    borderRadius: BorderRadius.circular(5.0),
                    buttons: stylistTimings,
                    onSelected: (i, selected) => {
                          print("Yes"),
                          print(stylistTimings[i]),
                          appointmentDetails.appointmentTime =
                              stylistTimings[i],
                        }),
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
                      Navigator.of(context).pushNamed(Services.routeName);
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
