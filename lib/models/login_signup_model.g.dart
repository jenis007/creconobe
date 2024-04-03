// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginSignupModel _$LoginSignupModelFromJson(Map<String, dynamic> json) =>
    LoginSignupModel(
      token: json['token'] as String?,
      message: json['message'] as String?,
      status: json['status'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LoginSignupModelToJson(LoginSignupModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'message': instance.message,
      'status': instance.status,
      'name': instance.name,
    };
