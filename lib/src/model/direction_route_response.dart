

import 'package:flutter_navigator/src/model/hints.dart';
import 'package:flutter_navigator/src/model/info.dart';
import 'package:flutter_navigator/src/model/paths.dart';

/// Represents the response for a direction route, which includes hints,
/// informational data, and a list of paths for the route.
class DirectionRouteResponse {
  /// Constructs a [DirectionRouteResponse] with optional hints, info, and paths.
  ///
  /// - [hints]: Optional route hints.
  /// - [info]: Optional route information.
  /// - [paths]: Optional list of paths for the route.
  DirectionRouteResponse({
    this.hints,
    this.info,
    this.paths,
  });

  /// Creates an instance of [DirectionRouteResponse] from JSON data.
  ///
  /// This constructor parses the JSON data to initialize the properties
  /// of the instance.
  ///
  /// - [json]: A [Map] representing the JSON response.
  factory DirectionRouteResponse.fromJson(Map<String, dynamic> json) {
    return DirectionRouteResponse(
      hints: json['hints'] != null
          ? Hints.fromJson(
              Map<String, dynamic>.from(json['hints'] as Map<dynamic, dynamic>),
            )
          : null,
      info: json['info'] != null
          ? Info.fromJson(json['info'] as Map<String, dynamic>)
          : null,
      paths: (json['paths'] as List<dynamic>?)
          ?.map((path) => Paths.fromJson(path as Map<String, dynamic>))
          .toList(),
    );
  }

  /// The route hints providing additional guidance details.
  final Hints? hints;

  /// Additional information about the direction route.
  final Info? info;

  /// A list of paths outlining the route.
  final List<Paths>? paths;


  /// Converts the [DirectionRouteResponse] instance to a JSON representation.
  ///
  /// This method creates a [Map] from the properties of the instance, which
  /// can then be serialized to JSON.
  ///
  /// Returns a [Map] representation of the object in JSON format.
  Map<String, dynamic> toJson() {
    return {
      if (hints != null) 'hints': hints!.toJson(),
      if (info != null) 'info': info!.toJson(),
      if (paths != null) 'paths': paths!.map((path) => path.toJson()).toList(),
    };
  }
}
