import 'package:creconobe_transformation/models/album.dart';
import 'package:json_annotation/json_annotation.dart';

import 'audioDataModel.dart';
part 'albumById.g.dart';

@JsonSerializable()
class AlbumById {
  final  String status;
  final Album album;
  final  List<Data> podcasts;




  AlbumById({required this.status, required this.album, required this.podcasts,});

  factory AlbumById.fromJson(Map<String, dynamic> json) =>
      _$AlbumByIdFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumByIdToJson(this);



}
