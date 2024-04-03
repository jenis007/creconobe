// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audioPlayListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioPlayListModel _$AudioPlayListModelFromJson(Map<String, dynamic> json) =>
    AudioPlayListModel(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      albums: (json['albums'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AudioPlayListModelToJson(AudioPlayListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'albums': instance.albums,
    };
