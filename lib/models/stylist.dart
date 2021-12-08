class Stylist {
  int age;
  String name;
  Map<String, List<String>> availableTimes;
  Map<String, List<String>> unavailableTimes;
  String startTime;
  String endTime;
  String gender;
  bool isAvailable;
  String profilePicture;

  Stylist({
    required this.availableTimes,
    required this.unavailableTimes,
    required this.name,
    this.age = 0,
    this.startTime = "",
    this.endTime = "",
    this.gender = "",
    this.isAvailable = true,
    this.profilePicture = "",
  });

  static convertToStylist(Map<String, dynamic>? stylistInfo) {
    Stylist stylist = new Stylist(
      name: "",
      availableTimes: Map<String, List<String>>(),
      unavailableTimes: Map<String, List<String>>(),
    );
    stylist.age = stylistInfo!["age"];
    stylist.name = stylistInfo["name"];
    stylist.endTime = stylistInfo["endTime"];
    stylist.startTime = stylistInfo["startTime"];
    stylist.gender = stylistInfo["gender"];
    stylist.isAvailable = stylistInfo["isAvailable"];
    stylist.profilePicture = stylistInfo["profilePicture"];

    Map<String, dynamic> availTimes = stylistInfo["availableTimes"];
    availTimes.forEach((key, value) {
      stylist.availableTimes[key] = new List<String>.from(value);
    });
    Map<String, dynamic> unAvailTimes = stylistInfo["unavailableTimes"];
    unAvailTimes.forEach((key, value) {
      stylist.unavailableTimes[key] = new List<String>.from(value);
    });

    return stylist;
  }
}
