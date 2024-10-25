import 'package:flutter_navigator/src/core/model/instruction.dart';
import 'package:flutter_navigator/src/core/model/points.dart';

/// Represents a path in a navigation response containing various properties
/// such as distance, weight, and instructions for navigation.
class Paths {
  /// The total distance of the path in meters.
  final double? distance;

  /// The weight associated with the path (could be a measure of cost).
  final double? weight;

  /// The estimated time to traverse the path in seconds.
  final int? time;

  /// The number of transfers needed along this path.
  final int? transfers;

  /// Indicates whether the points along the path are encoded.
  final bool? pointsEncoded;

  /// A bounding box defining the geographical area of the path.
  final List<double>? bbox;

  /// The geographical points that define the path.
  final Points? points;

  /// A list of navigation instructions associated with the path.
  final List<Instruction>? instructions;

  /// The total ascent along the path in meters.
  final int? ascend;

  /// The total descent along the path in meters.
  final int? descend;

  /// The snapped waypoints along the path.
  final Points? snappedWaypoints;

  /// Constructs a [Paths] instance with optional parameters.
  Paths({
    this.distance,
    this.weight,
    this.time,
    this.transfers,
    this.pointsEncoded,
    this.bbox,
    this.points,
    this.instructions,
    this.ascend,
    this.descend,
    this.snappedWaypoints,
  });

  /// Creates a [Paths] instance from a JSON object.
  ///
  /// - [json]: A [Map] representing the JSON data.
  factory Paths.fromJson(Map<String, dynamic> json) {
    return Paths(
      distance: (json['distance'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      time: json['time'] as int?,
      transfers: json['transfers'] as int?,
      pointsEncoded: json['points_encoded'] as bool?,
      bbox: (json['bbox'] as List<dynamic>?)?.map((e) => (e as num).toDouble()).toList(),
      points: json['points'] != null
          ? Points.fromJson(json['points'] as Map<String, dynamic>)
          : null,
      instructions: json['instructions'] != null
          ? (json['instructions'] as List<dynamic>)
          .map((v) => Instruction.fromJson(v as Map<String, dynamic>))
          .toList()
          : null,
      ascend: json['ascend'] as int?,
      descend: json['descend'] as int?,
      snappedWaypoints: json['snapped_waypoints'] != null
          ? Points.fromJson(json['snapped_waypoints'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts the [Paths] instance into a JSON representation.
  ///
  /// Returns a [Map] suitable for JSON serialization.
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
      data['instructions'] = instructions!.map((instruction) => instruction.toJson()).toList();
    }

    data['ascend'] = ascend;
    data['descend'] = descend;

    if (snappedWaypoints != null) {
      data['snapped_waypoints'] = snappedWaypoints!.toJson();
    }

    return data;
  }
}
