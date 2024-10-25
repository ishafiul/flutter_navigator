/// Represents geographical points, including their type and coordinates.
class Points {

  /// Constructs a [Points] instance with optional parameters.
  Points({this.type, this.coordinates});

  /// Creates a [Points] instance from a JSON object.
  ///
  /// - [json]: A [Map] representing the JSON data.
  factory Points.fromJson(Map<String, dynamic> json) {
    return Points(
      type: json['type'] as String?,
      coordinates: json['coordinates'] != null
          ? List<List<double>>.from(
          (json['coordinates'] as List<dynamic>).map<List<double>>(
                (coordinate) {
              return List<double>.from(
                (coordinate as List<dynamic>).map<double>(
                      (element) => (element as num).toDouble(),
                ),
              );
            },
          ))
          : null,
    );
  }
  /// The type of the points (e.g., "Point", "LineString", "Polygon").
  final String? type;

  /// A list of coordinates representing the geographical points.
  final List<List<double>>? coordinates;

  /// Converts the [Points] instance into a JSON representation.
  ///
  /// Returns a [Map] suitable for JSON serialization.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'type': type,
      'coordinates': coordinates,
    };
    return data;
  }
}
