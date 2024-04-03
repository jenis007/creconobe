// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audioDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as int,
      audio_name: json['audio_name'] as String?,
      audio_album: json['audio_album'] as String?,
      audio_episode: json['audio_episode'] as String?,
      category: json['category'] as String?,
      tag: json['tag'] as String?,
      singer: json['singer'] as String?,
      cover_photo: json['cover_photo'] as String?,
      audio_file: json['audio_file'] as String?,
      playable: json['playable'] as bool,
      payment: json['payment'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'audio_name': instance.audio_name,
      'audio_album': instance.audio_album,
      'audio_episode': instance.audio_episode,
      'category': instance.category,
      'tag': instance.tag,
      'singer': instance.singer,
      'cover_photo': instance.cover_photo,
      'audio_file': instance.audio_file,
      'playable': instance.playable,
      'payment': instance.payment,
    };
