// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albumById.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumById _$AlbumByIdFromJson(Map<String, dynamic> json) => AlbumById(
      status: json['status'] as String,
      album: Album.fromJson(json['album'] as Map<String, dynamic>),
      podcasts: (json['podcasts'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumByIdToJson(AlbumById instance) => <String, dynamic>{
      'status': instance.status,
      'album': instance.album,
      'podcasts': instance.podcasts,
    };
