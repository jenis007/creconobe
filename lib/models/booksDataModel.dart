import 'package:json_annotation/json_annotation.dart';
part 'booksDataModel.g.dart';

@JsonSerializable()
class BooksDataModel {
  int? id;
  String? book_name;
  String? category;
  String? tag;
  String? title;
  String? introduction;
  String? authorname;
  String? publishdate;
  String? book_cover;
  String? bookaudio;
  String? book_pdf;
  bool? playable;

  BooksDataModel(
      {required this.id,
      required this.book_name,
      required this.category,
      required this.tag,
      required this.title,
      required this.introduction,
      required this.authorname,
      required this.publishdate,
      required this.book_cover,
      required this.bookaudio,
      required this.book_pdf,
      required this.playable});
  factory BooksDataModel.fromJson(Map<String, dynamic> json) => _$BooksDataModelFromJson(json);
}
