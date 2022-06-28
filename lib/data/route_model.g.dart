// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) => RouteModel(
      json['id'] as String,
      json['ownerId'] as String,
      json['title'] as String,
      json['description'] as String,
      (json['distance'] as num).toDouble(),
      json['duration'] as int,
      Map<String, int>.from(json['rates'] as Map),
    );

Map<String, dynamic> _$RouteModelToJson(RouteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'title': instance.title,
      'description': instance.description,
      'distance': instance.distance,
      'duration': instance.duration,
      'rates': instance.rates,
    };
