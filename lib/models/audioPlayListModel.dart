import 'package:json_annotation/json_annotation.dart';

import 'album.dart';
import 'audioDataModel.dart';
part 'audioPlayListModel.g.dart';


@JsonSerializable()
class AudioPlayListModel{
  final String status;
  final List<Data> data;
  final List<Album>albums;



  AudioPlayListModel({required this.status,required this.data,required this.albums});
  factory AudioPlayListModel.fromJson(Map<String, dynamic> json) =>
      _$AudioPlayListModelFromJson(json);



}


