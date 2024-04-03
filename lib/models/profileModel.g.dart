// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      subscription: json['subscription'] as String,
      start_date: json['start_date'] as String,
      end_date: json['end_date'] as String,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'email': instance.email,
      'subscription': instance.subscription,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
    };
