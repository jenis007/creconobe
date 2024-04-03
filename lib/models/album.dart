import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album{
  final int id;
  final String cover_photo;
  final String? name;
  final String? description;



  Album({required this.id,required this.cover_photo,required this.name,required this.description});
  factory Album.fromJson(Map<String, dynamic> json) =>
      _$AlbumFromJson(json);



}