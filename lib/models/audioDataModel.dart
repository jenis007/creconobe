import 'package:json_annotation/json_annotation.dart';
part 'audioDataModel.g.dart';


@JsonSerializable()
class Data {

  final int id;
  final String? audio_name;
  final String? audio_album;
  final String? audio_episode;
  final String? category;
  final String? tag;
  final String? singer;
  final String? cover_photo;
  final String? audio_file;
  final bool playable;
  final  String payment;



  Data({
    required this.id,
    required this.audio_name,
    required this.audio_album,
    required this.audio_episode,
    required this.category,
    required this.tag,
    required this.singer,
    required this.cover_photo,
    required this.audio_file,
    required this.playable,
    required this.payment,

  });


  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);





}