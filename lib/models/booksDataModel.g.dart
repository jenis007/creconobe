// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booksDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksDataModel _$BooksDataModelFromJson(Map<String, dynamic> json) => BooksDataModel(
      id: json['id'] as int?,
      book_name: json['book_name'] as String?,
      category: json['category'] as String?,
      tag: json['tag'] as String?,
      title: json['title'] as String?,
      introduction: json['introduction'] as String?,
      authorname: json['authorname'] as String?,
      publishdate: json['publishdate'] as String?,
      book_cover: json['book_cover'] as String?,
      bookaudio: json['bookaudio'] as String?,
      book_pdf: json['book_pdf'] as String?,
      playable: json['playable'] as bool?,
    );

Map<String, dynamic> _$BooksDataModelToJson(BooksDataModel instance) => <String, dynamic>{
      'id': instance.id,
      'book_name': instance.book_name,
      'category': instance.category,
      'tag': instance.tag,
      'title': instance.title,
      'introduction': instance.introduction,
      'authorname': instance.authorname,
      'publishdate': instance.publishdate,
      'book_cover': instance.book_cover,
      'bookaudio': instance.bookaudio,
      'book_pdf': instance.book_pdf,
      'playable': instance.playable,
    };
