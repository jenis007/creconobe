// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booksMainModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksMainModel _$BooksMainModelFromJson(Map<String, dynamic> json) =>
    BooksMainModel(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => BooksDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BooksMainModelToJson(BooksMainModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
