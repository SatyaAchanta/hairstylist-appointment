// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stylist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stylist _$StylistFromJson(Map<String, dynamic> json) => Stylist(
      availableTimes: (json['availableTimes'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      unavailableTimes: (json['unavailableTimes'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      name: json['name'] as String,
      age: json['age'] as int? ?? 0,
      startTime: json['startTime'] as String? ?? "",
      endTime: json['endTime'] as String? ?? "",
      gender: json['gender'] as String? ?? "",
      isAvailable: json['isAvailable'] as bool? ?? true,
      profilePicture: json['profilePicture'] as String? ?? "",
    );

Map<String, dynamic> _$StylistToJson(Stylist instance) => <String, dynamic>{
      'age': instance.age,
      'name': instance.name,
      'availableTimes': instance.availableTimes,
      'unavailableTimes': instance.unavailableTimes,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'gender': instance.gender,
      'isAvailable': instance.isAvailable,
      'profilePicture': instance.profilePicture,
    };
