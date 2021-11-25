class Hairstylist {
  final String name;
  final String id;
  int ratings;
  String gender;
  bool isAvailableToday;
  String profileImage;
  List<String> availableTimes;
  List<String> services;

  Hairstylist({
    required this.name,
    required this.gender,
    required this.isAvailableToday,
    required this.availableTimes,
    required this.services,
    this.id = "sample",
    this.ratings = 5,
    this.profileImage = "",
  });

  Hairstylist.fromJson(Map<String, dynamic> json)
      : this.name = json["name"],
        this.gender = json["gender"],
        this.id = json["id"],
        this.ratings = int.parse(json["ratings"]),
        this.isAvailableToday = true,
        this.availableTimes = json["timeSlots"],
        this.profileImage = json["profileImage"],
        this.services = json["Services"];

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'gender': this.gender,
        'id': this.id,
        'ratings': this.ratings,
        'isAvailableToday': true,
        'timeSlots': this.availableTimes,
        'profileImage': this.profileImage,
        'services': this.services
      };
}
