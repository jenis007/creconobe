import 'package:json_annotation/json_annotation.dart';
part 'login_signup_model.g.dart';

@JsonSerializable()
class LoginSignupModel {
final  String ?token;
final String ?message;
final  String ?status;
final String ? name;





  LoginSignupModel(
      {required this.token, required this.message, required this.status,required this.name});

  factory LoginSignupModel.fromJson(Map<String, dynamic> json) =>
      _$LoginSignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginSignupModelToJson(this);



}
