import 'package:json_annotation/json_annotation.dart';
import 'booksDataModel.dart';
part 'booksMainModel.g.dart';


@JsonSerializable()
class BooksMainModel{
  final String status;
  final List<BooksDataModel> data;



  BooksMainModel({required this.status,required this.data});
  factory BooksMainModel.fromJson(Map<String, dynamic> json) =>
      _$BooksMainModelFromJson(json);



}