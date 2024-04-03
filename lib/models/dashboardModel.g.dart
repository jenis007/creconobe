// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboardModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) =>
    DashboardModel(
      json['status'] as String,
      (json['recommended'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['playlists'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['brain_waves'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['relax'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['pdf'] as List<dynamic>)
          .map((e) => BooksDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'recommended': instance.recommended,
      'playlists': instance.playlists,
      'brain_waves': instance.brain_waves,
      'relax': instance.relax,
      'pdf': instance.pdf,
    };
