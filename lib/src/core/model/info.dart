/// Represents information related to the direction route response,
/// including copyright notices and processing time.
class Info {
  /// A list of copyright notices associated with the route response.
  final List<String>? copyrights;

  /// The time taken to generate the route response (in milliseconds).
  final int? took;

  /// Constructs an [Info] instance with optional [copyrights] and [took] values.
  Info({
    this.copyrights,
    this.took,
  });

  /// Creates an [Info] instance from JSON data.
  ///
  /// - [json]: A [Map] representing the JSON object.
  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      copyrights: (json['copyrights'] as List<dynamic>?)?.map((e) => e as String).toList(),
      took: json['took'] as int?,
    );
  }

  /// Converts the [Info] instance into a JSON representation.
  ///
  /// Returns a [Map] suitable for JSON serialization.
  Map<String, dynamic> toJson() {
    return {
      if (copyrights != null) 'copyrights': copyrights,
      if (took != null) 'took': took,
    };
  }
}
