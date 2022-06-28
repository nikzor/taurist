import 'package:json_annotation/json_annotation.dart';

part 'route_model.g.dart';

@JsonSerializable()
class RouteModel {
  final String id;
  final String ownerId;
  final String title;
  final String description;

  // Distance of route in kilometers
  final double distance;

  // Duration of route in minutes (approximate)
  final int duration;

  // Mapping: userId -> rate
  final Map<String, int> rates;

  RouteModel(this.id, this.ownerId, this.title, this.description, this.distance,
      this.duration, this.rates);

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteModelToJson(this);

  String durationAsTimeString() {
    int h = duration ~/ 60;
    int m = duration % 60;
    return "$h hr $m min";
  }
}
