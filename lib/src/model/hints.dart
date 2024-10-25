/// Represents the hints provided in the direction route response,
/// including data about visited nodes.
class Hints {

  /// Constructs a [Hints] instance with optional [visitedNodesSum]
  /// and [visitedNodesAverage] values.
  Hints({
    this.visitedNodesSum,
    this.visitedNodesAverage,
  });

  /// Creates a [Hints] instance from JSON data.
  ///
  /// - [json]: A [Map] representing the JSON object.
  factory Hints.fromJson(Map<String, dynamic> json) {
    return Hints(
      visitedNodesSum: json['visited_nodes.sum'] as int?,
      visitedNodesAverage: json['visited_nodes.average'] as int?,
    );
  }
  /// Sum of visited nodes during route calculation.
  final int? visitedNodesSum;

  /// Average of visited nodes during route calculation.
  final int? visitedNodesAverage;

  /// Converts the [Hints] instance into a JSON representation.
  ///
  /// Returns a [Map] suitable for JSON serialization.
  Map<String, dynamic> toJson() {
    return {
      if (visitedNodesSum != null) 'visited_nodes.sum': visitedNodesSum,
      if (visitedNodesAverage != null) 'visited_nodes.average': visitedNodesAverage,
    };
  }
}
