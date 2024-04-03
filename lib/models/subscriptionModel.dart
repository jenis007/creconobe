
import 'package:json_annotation/json_annotation.dart';
part 'subscriptionModel.g.dart';
@JsonSerializable()
 class SubscriptionModel{
  final String status;
  final List<Datum> data;

  SubscriptionModel(this.status, this.data);
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}
@JsonSerializable()
 class Datum{
   final int id;
   final String name;
   final String price;
   final String currency;
   final String validity;
   final bool paid;
   final List<String> description;

   Datum(this.id, this.name, this.price, this.currency, this.validity, this.paid,
       this.description);
   factory Datum.fromJson(Map<String, dynamic> json) =>
       _$DatumFromJson(json);

   Map<String, dynamic> toJson() => _$DatumToJson(this);
 }
