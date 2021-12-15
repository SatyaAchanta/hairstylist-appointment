import 'package:json_annotation/json_annotation.dart';

part 'stylist.g.dart';

@JsonSerializable()
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

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Stylist.fromJson(Map<String, dynamic> json) =>
      _$StylistFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StylistToJson(this);
}
