import 'package:flutter_navigator/src/core/model/instructions.dart';
import 'package:flutter_navigator/src/core/model/points.dart';

class Paths {
  Paths({
    double? distance,
    double? weight,
    int? time,
    int? transfers,
    bool? pointsEncoded,
    List<double>? bbox,
    Points? points,
    List<Instructions>? instructions,
    int? ascend,
    int? descend,
    Points? snappedWaypoints,
  }) {
    if (distance != null) {
      distance = distance;
    }
    if (weight != null) {
      weight = weight;
    }
    if (time != null) {
      time = time;
    }
    if (transfers != null) {
      transfers = transfers;
    }
    if (pointsEncoded != null) {
      pointsEncoded = pointsEncoded;
    }
    if (bbox != null) {
      bbox = bbox;
    }
    if (points != null) {
      points = points;
    }
    if (instructions != null) {
      instructions = instructions;
    }
    if (ascend != null) {
      ascend = ascend;
    }
    if (descend != null) {
      descend = descend;
    }
    if (snappedWaypoints != null) {
      snappedWaypoints = snappedWaypoints;
    }
  }

  Paths.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] as double?;
    weight = json['weight'] as double?;
    time = json['time'] as int?;
    transfers = json['transfers'] as int?;
    pointsEncoded = json['points_encoded'] as bool?;
    bbox = json['bbox'] as List<double>?;
    points = json['points'] != null
        ? Points.fromJson(json['points'] as Map<String, dynamic>)
        : null;
    if (json['instructions'] != null) {
      instructions = <Instructions>[];
      json['instructions'].forEach((v) {
        instructions!.add(Instructions.fromJson(v as Map<String, dynamic>));
      });
    }
    ascend = json['ascend'] as int?;
    descend = json['descend'] as int?;
    snappedWaypoints = json['snapped_waypoints'] != null
        ? Points.fromJson(json['snapped_waypoints'] as Map<String, dynamic>)
        : null;
  }
  double? distance;
  double? weight;
  int? time;
  int? transfers;
  bool? pointsEncoded;
  List<double>? bbox;
  Points? points;
  List<Instructions>? instructions;
  int? ascend;
  int? descend;
  Points? snappedWaypoints;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['distance'] = distance;
    data['weight'] = weight;
    data['time'] = time;
    data['transfers'] = transfers;
    data['points_encoded'] = pointsEncoded;
    data['bbox'] = bbox;
    if (points != null) {
      data['points'] = points!.toJson();
    }
    if (instructions != null) {
      data['instructions'] = instructions!.map((v) => v.toJson()).toList();
    }
    data['ascend'] = ascend;
    data['descend'] = descend;
    if (snappedWaypoints != null) {
      data['snapped_waypoints'] = snappedWaypoints!.toJson();
    }
    return data;
  }
}
