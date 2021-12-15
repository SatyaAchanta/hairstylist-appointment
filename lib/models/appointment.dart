import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  DateTime appointmentDate;
  String appointmentTime;
  String stylistName;
  int appointmentTimestamp;

  Appointment({
    required this.appointmentDate,
    this.appointmentTimestamp = 0,
    this.appointmentTime = "",
    this.stylistName = "",
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
