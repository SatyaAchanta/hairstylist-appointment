// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      appointmentTimestamp: json['appointmentTimestamp'] as int? ?? 0,
      appointmentTime: json['appointmentTime'] as String? ?? "",
      stylistName: json['stylistName'] as String? ?? "",
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'appointmentDate': instance.appointmentDate.toIso8601String(),
      'appointmentTime': instance.appointmentTime,
      'stylistName': instance.stylistName,
      'appointmentTimestamp': instance.appointmentTimestamp,
    };
