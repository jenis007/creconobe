import 'package:creconobe_transformation/models/booksDataModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'album.dart';
part 'dashboardModel.g.dart';
@JsonSerializable()
class DashboardModel
{
  final String status;
  final List<Album> recommended;
  final List<Album> playlists;
  final List<Album> brain_waves;
  final List<Album> relax;
  final List<BooksDataModel> pdf;

  DashboardModel(this.status, this.recommended, this.playlists,
      this.brain_waves, this.relax, this.pdf);
  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);

}