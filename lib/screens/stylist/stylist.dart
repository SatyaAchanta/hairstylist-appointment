import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/stylist/appointment_date.dart';
import '../../screens/stylist/stylist_dropdown.dart';
import '../../screens/stylist/stylist_timings.dart';
import '../../screens/stylist/schedule_appointment_button.dart';
import '../../screens/appointment/user_appointments.dart';
import '../../controller/dashboard_controller.dart';

class Stylist extends StatelessWidget {
  Stylist({Key? key}) : super(key: key);
  final String selectHairstylist = "Select Hairstylist";
  final DashboardController dashboard = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<DashboardController>(
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: IndexedStack(
                index: dashboard.tabIndex,
                children: [
                  Column(
                    children: [
                      AppointmentDate(),
                      StylistDropdown(),
                      StylistTimings(),
                      ScheduleAppointment(),
                    ],
                  ),
                  UserAppointments(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_today,
                  ),
                  label: 'Schedule Appointment',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                  ),
                  label: 'My Appointments',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
