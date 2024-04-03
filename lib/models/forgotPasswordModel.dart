import 'package:json_annotation/json_annotation.dart';
part 'forgotPasswordModel.g.dart';


@JsonSerializable()
class ForgotPasswordModel {
  final String message;
  final  String status;





  ForgotPasswordModel(
      {required this.message, required this.status});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordModelToJson(this);



}