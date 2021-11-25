import 'hairstylist.dart';

List<String> timeSlots = [
  "7.30 AM",
  "8.00 AM",
  "8.30 AM",
  "9.00 AM",
  "9.30 AM",
  "10.30 AM",
  "11.00 AM",
  "11.30 AM",
  "1.00 PM",
  "1.30 PM",
  "2.00 PM",
  "2.30 PM",
  "3.00 PM",
  "4.00 PM",
  "4.30 PM",
];

List<String> services = [
  "haircut",
  "beard trim",
  "hair color",
  "kids haircut",
  "perm",
  "hair shampoo",
  "neck trim",
  "Makeup",
  "Eyebrow Waxing",
  "Manicure",
  "Pedicure",
  "Neck lining",
  "Hair lining",
];

final List<Hairstylist> hairstylists = [
  Hairstylist(
    name: "Name1",
    gender: "Male",
    id: "1",
    ratings: 5,
    isAvailableToday: true,
    availableTimes: timeSlots,
    services: services,
  ),
  Hairstylist(
    name: "Name2",
    gender: "Male",
    id: "1",
    ratings: 5,
    isAvailableToday: true,
    availableTimes: timeSlots,
    services: services,
  ),
  Hairstylist(
    name: "Name3",
    gender: "Male",
    id: "1",
    ratings: 5,
    isAvailableToday: false,
    availableTimes: timeSlots,
    services: services,
  ),
  Hairstylist(
    name: "Name4",
    gender: "Male",
    id: "1",
    ratings: 5,
    isAvailableToday: true,
    availableTimes: timeSlots,
    services: services,
  ),
  Hairstylist(
    name: "Name5",
    gender: "Male",
    id: "1",
    ratings: 5,
    isAvailableToday: true,
    availableTimes: timeSlots,
    services: services,
  ),
  Hairstylist(
    name: "Name6",
    gender: "Male",
    id: "1",
    ratings: 5,
    isAvailableToday: false,
    availableTimes: timeSlots,
    services: services,
  ),
  Hairstylist(
    name: "Name7",
    gender: "Male",
    id: "1",
    ratings: 5,
    isAvailableToday: false,
    availableTimes: timeSlots,
    services: services,
  ),
  Hairstylist(
    name: "Name8",
    gender: "Male",
    id: "1",
    ratings: 5,
    isAvailableToday: true,
    availableTimes: timeSlots,
    services: services,
  ),
];

List<String> get stylistNames {
  List<String> names = [];
  hairstylists.forEach((element) {
    names.add(element.name);
  });
  print("names are ${names.toString()}");
  return names;
}

bool isStylistAvailable(String name) {
  for (var stylist in hairstylists) {
    if (stylist.name == name) {
      return stylist.isAvailableToday;
    }
  }

  return false;
}

List<String> getStylistTimings(String name) {
  Hairstylist stylist =
      hairstylists.firstWhere((element) => element.name == name);
  return stylist.availableTimes;
}

List<String> getStylistServices(String name) {
  Hairstylist stylist =
      hairstylists.firstWhere((element) => element.name == name);
  return stylist.services;
}
