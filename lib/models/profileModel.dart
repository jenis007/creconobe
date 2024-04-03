import 'package:json_annotation/json_annotation.dart';
part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  final  String fullname;
  final String email;
  final  String subscription;
  final String start_date,end_date;




  ProfileModel({required this.fullname, required this.email, required this.subscription,required this.start_date, required this.end_date});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);



}
