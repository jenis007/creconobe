// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscriptionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) =>
    SubscriptionModel(
      json['status'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      json['id'] as int,
      json['name'] as String,
      json['price'] as String,
      json['currency'] as String,
      json['validity'] as String,
      json['paid'] as bool,
      (json['description'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'currency': instance.currency,
      'validity': instance.validity,
      'paid': instance.paid,
      'description': instance.description,
    };
